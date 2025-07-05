#include <iostream>
#include <vector>
#include <thread>
#include <atomic>
#include <chrono>
#include <random>
#include <algorithm>
#include <iomanip>
#include <cmath>
#include <cstdint>

constexpr size_t K = 10;
constexpr size_t VECTOR_SIZE = 1'000'00 * K;
constexpr auto BENCHMARK_DURATION = std::chrono::seconds(4);
constexpr double BASELINE_ITERATIONS = 100.0;
constexpr size_t X = 42;
constexpr size_t X_SIZE = 10;

// CRC64-like function
uint64_t compute_crc64(uint64_t a, uint64_t b, uint64_t c, uint64_t d) {
    uint64_t crc = a ^ b ^ c ^ d;
    for (int i = 0; i < 64; ++i)
        crc = (crc >> 1) ^ ( -static_cast<int64_t>(crc & 1) & 0xC96C5795D7870F42ULL );
    return crc;
}

// Math calculation with logarithms
double compute_math_log(uint64_t a, uint64_t b, uint64_t c, uint64_t d) {
    double x = static_cast<double>(a + 1);
    double y = static_cast<double>(b + 1);
    double z = static_cast<double>(c + d + 1);

    return std::log2(x) * std::sqrt(y) / std::log1p(z);
}

// Combined heavy computation block for benchmark
uint64_t heavy_block(uint64_t a, uint64_t b, uint64_t c, uint64_t d) {
    uint64_t crc = compute_crc64(a, b, c, d);
    double math = compute_math_log(a, b, c, d);

    // Combine results and return as uint64_t
    volatile double combined = crc * math;
    return static_cast<uint64_t>(combined);
}

//AVX2
void vector_modify(std::vector<uint64_t>& data, uint64_t add_val) {
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] += add_val;
        data[i] ^= (data[i] >> 3);
        data[i] *= 0x9E3779B97F4A7C15ULL; // hash
    }
}

void expand_vector_10x(std::vector<uint64_t>& data) {
    size_t original_size = data.size();
    data.resize(original_size * X_SIZE);  

    for (size_t repeat = 1; repeat < X_SIZE; ++repeat) {
        size_t offset = repeat * original_size;
        for (size_t i = 0; i < original_size; ++i) {
            uint64_t val = data[i] + repeat;
            val ^= i;
            data[offset + i] = val;
        }
    }
}


void worker(std::atomic<bool>& stop_flag, std::atomic<uint64_t>& counter, std::atomic<uint64_t>& sum) {
    std::mt19937_64 rng(std::random_device{}());
    std::uniform_int_distribution<uint64_t> dist(1, VECTOR_SIZE); 

    while (!stop_flag.load(std::memory_order_relaxed)) {
        std::vector<uint64_t> data;
        for (size_t i = 0; i < VECTOR_SIZE; ++i) {
            uint64_t a = dist(rng);
            uint64_t b = dist(rng);
            uint64_t c = a + 4;
            uint64_t d = b + 11;

            uint64_t value = heavy_block(a,b,c,d);
            data.push_back(value);
        }
		std::sort(data.begin(), data.end());
        expand_vector_10x(data);
		vector_modify(data, X);
        counter.fetch_add(1, std::memory_order_relaxed);
		sum.fetch_add(data.at(dist(rng)*X_SIZE), std::memory_order_relaxed);
    }
}

int main() {
    const unsigned int hw_threads = std::thread::hardware_concurrency();
    const unsigned int num_threads = hw_threads * 2;

    std::cout << "Hardware threads: " << hw_threads << "\n";

    std::atomic<bool> stop_flag{false};
    std::vector<std::thread> threads;
    std::vector<std::atomic<uint64_t>> counters(num_threads);
	std::vector<std::atomic<uint64_t>> sums(num_threads);

    for (auto& c : counters)
        c.store(0);
	
	for (auto& c : sums)
        c.store(0);

    for (unsigned int i = 0; i < num_threads; ++i)
        threads.emplace_back(worker, std::ref(stop_flag), std::ref(counters[i]), std::ref(sums[i]));

    std::this_thread::sleep_for(BENCHMARK_DURATION);
    stop_flag.store(true);

    for (auto& t : threads)
        t.join();

    uint64_t total_iterations = 0;
    for (const auto& c : counters)
        total_iterations += c.load();
	
	uint64_t total_sum = 0;
    for (const auto& s : sums)
        total_sum += s.load();

	std::cout << "Total iterations across 1 hardware thread: " << total_iterations/hw_threads << "\n";
    std::cout << "Total iterations across all threads: " << total_iterations << "\n";
	double performance_ratio = total_iterations / BASELINE_ITERATIONS;
	std::cout << std::fixed << std::setprecision(2)
          << "Performance: x" << performance_ratio << " of 4 vCPU AMD Genoa(zen4) \n";
    return 0;
}
