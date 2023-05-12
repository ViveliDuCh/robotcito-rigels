function[T, trans] = GENDGM(sigma, a, alpha, d, theta, q)

    h = size(sigma);
    n = h(1);
    z = 0;
    ans = 1;
    x{1} = 0;
    y{1} = 0;
    w{1} = 0;

    for z = 1:n

        if sigma(z) == 0
            A{z} = rotZ(q(z))*transZ(d(z))*rotX(alpha(z))*transX(a(z));
    
        elseif sigma(z) == 1
            A{z}=rotZ(theta(z))*transZ(q(z))*rotX(alpha(z))*transX(a(z));

        end
    trans(:,:,z) = A{z};
    ans * A{z};
    H=A{z};
    
    end
    
    T = ans;

end