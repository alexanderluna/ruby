require 'benchmark'
require 'prime'
require './my_prime'

one_million      = 1_000_000
ten_thousand     = 10_000
thousand         = 1_000

with_negative    = (-100..1_000).to_a
small_non_primes = (0..1_000).reject {|n| Prime.prime?(n) }
small_primes     = Prime.take(2000)
large_non_primes = (10_999_000..11_000_000).reject {|n| Prime.prime?(n) }
large_primes     = (10_999_000..11_000_000).select {|n| Prime.prime?(n) }

Benchmark.bmbm(20) do |bm|
  bm.report('Old: 1_000_000 * prime?') do
    one_million.times do |i|
      i.prime?
    end
  end

  bm.report('New: 1_000_000 * prime?') do
    one_million.times do |i|
      i.isprime?
    end
  end

  bm.report('Old: 10_000 * -100 to 1_000') do
    ten_thousand.times do |i|
      with_negative.select(&:prime?)
    end
  end

  bm.report('New: 10_000 * -100 to 1_000') do
    ten_thousand.times do |i|
      with_negative.select(&:isprime?)
    end
  end

  bm.report('Old: 1_000 * small non primes') do
    thousand.times do |i|
      small_non_primes.select(&:prime?)
    end
  end

  bm.report('New: 1_000 * small non primes') do
    thousand.times do |i|
      small_non_primes.select(&:isprime?)
    end
  end

  bm.report('Old: 1_000 * small primes') do
    thousand.times do |i|
      small_primes.select(&:prime?)
    end
  end

  bm.report('New: 1_000 * small primes') do
    thousand.times do |i|
      small_primes.select(&:isprime?)
    end
  end

  bm.report('Old: 1_000 * large primes') do
    thousand.times do |i|
      large_primes.select(&:prime?)
    end
  end

  bm.report('New: 1_000 * large primes') do
    thousand.times do |i|
      large_primes.select(&:isprime?)
    end
  end

  bm.report('Old: 1_000 * large non primes') do
    thousand.times do |i|
      large_non_primes.select(&:prime?)
    end
  end

  bm.report('New: 1_000 * large non primes') do
    thousand.times do |i|
      large_non_primes.select(&:isprime?)
    end
  end
end
