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

function verbose_recursive_binary_search(input, target, low = 1, high = length(input))
    if low > high return nothing end
    mid = div(low + high, 2)
    guess = input[mid]
    if input[mid] == target
        return mid
    elseif target < guess
        return verbose_recursive_binary_search(input, target, low, high - 1)
    else
        return verbose_recursive_binary_search(input, target, low + 1, high)
    end
end

function recursive_binary_search(input, target)
    print("Input: " * string(input) * "\n")
    len = length(input)
    if len == 0
        return nothing
    elseif len == 1
        return input[begin] == target ? 1 : nothing
    end
    mid = div(len + 1, 2)
    guess = input[mid]
    print("Mid: " * string(mid) * "\n")
    print("Guess: " * string(guess) * "\n")
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


