function V = numeric1D(nx, bc_left, bc_right)
%NUMERIC Calculates the numeric solution using the finite difference method
    global C;
    G = sparse(nx, nx);
    B = zeros(1, nx);
    for i=1:nx

        if (i == 1) % Left Side
            G(i,i) = 1;
            B(i) = bc_left;
        elseif i == nx % Right side
            G(i,i) = 1;
            B(i) = bc_right;
        else % Bulk Area
            G(i,i)   = -2;
            G(i,i+1) =  1;
            G(i,i-1) =  1;
        end
    end
    
    V = G\B';
end

