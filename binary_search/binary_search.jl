using BenchmarkTools

function iterative_binary_search(input, target)
    low = 1
    high = length(input)
    while low <= high
        mid = div(low + high, 2)
        guess = input[mid]
        if guess == target
            return mid
        elseif guess > target
            high = mid - 1
        else
            low = mid + 1
        end
    end
    # failure case, target not in array
    return nothing
end

function recursive_binary_search(input, target)
    len = length(input)
    if len == 0
        return nothing
    elseif len == 1
        return input[begin] == target ? 1 : nothing
    end
    mid = div(len + 1, 2)
    guess = input[mid]
    if guess == target
        return mid
    elseif guess > target
        return recursive_binary_search(input[begin:(mid - 1)], target)
    else
        ret = recursive_binary_search(input[(mid + 1):end], target) 
        return isnothing(ret) ? nothing : mid + ret
    end
end

function test_bsearch(func, input, target)
    index = findall(x -> x == target, input)
    answer = length(index) == 1 ? first(index) : nothing
    bsearch_answer = func(input, target)
    return answer, bsearch_answer
end


test_bsearch(iterative_binary_search, 1:1000, -1)
test_bsearch(iterative_binary_search, 1:1000, 1)
test_bsearch(iterative_binary_search, 1:1000, 67)
test_bsearch(iterative_binary_search, 1:1000, 1000)
test_bsearch(iterative_binary_search, 1:3:1000, 1)
test_bsearch(iterative_binary_search, 1:3:1000, 1000)
test_bsearch(iterative_binary_search, 1:3:1000, 1010)
test_bsearch(iterative_binary_search, 1:3:1000, -2)
test_bsearch(iterative_binary_search, 1:3:1000, 3)

test_bsearch(recursive_binary_search, 1:1000, -1)
test_bsearch(recursive_binary_search, 1:1000, 1)
test_bsearch(recursive_binary_search, 1:1000, 67)
test_bsearch(recursive_binary_search, 1:1000, 1000)
test_bsearch(recursive_binary_search, 1:3:1000, 1)
test_bsearch(recursive_binary_search, 1:3:1000, 1000)
test_bsearch(recursive_binary_search, 1:3:1000, 1010)
test_bsearch(recursive_binary_search, 1:3:1000, -2)
test_bsearch(recursive_binary_search, 1:3:1000, 3)

const domain = 1:1000
const target = 11

@benchmark(recursive_binary_search(1:1000, target))
@benchmark(iterative_binary_search(1:1000, target))


