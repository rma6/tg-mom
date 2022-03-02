function r = cinv(arr)
    for i = 1:size(arr, 2)
        if imag(arr(i)) > 0
            arr(i) = -arr(i);
        end
    end
    r = arr;
end