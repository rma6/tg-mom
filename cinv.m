function r = cinv(arr) %inverts complex number if imaginary part is positive
    for i = 1:size(arr, 2)
        if imag(arr(i)) > 0
            arr(i) = -arr(i);
        end
    end
    r = arr;
end