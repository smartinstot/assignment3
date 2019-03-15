function V = numeric(nx, ny, cMap, bc_left, bc_right, bc_top, bc_bottom)
%NUMERIC Calculates the numeric solution using the finite difference method
%       Infinite BC means that it is insolated there
    global C;
    G = sparse(nx*ny, ny*nx);
    B = zeros(1, nx*ny);
    for i=1:nx
        for j=1:ny
            n = map(i,j, nx, ny);
            nxm = map(i-1,j, nx, ny);
            nxp = map(i+1,j, nx, ny);
            nym = map(i,j-1, nx, ny);
            nyp = map(i,j+1, nx, ny);

            if (i == 1 && j == 1)
                if (bc_left == Inf)
                    rxp = (cMap(i,j) + cMap(i+1,j))/2;
                    ryp = (cMap(i,j) + cMap(i,j+1))/2;

                    G(n,n)   = -(rxp+ryp);
                    G(n,nxp) =  rxp;
                    G(n,nyp) =  ryp;
                else
                    G(n,n) = 1;
                    B(n) = bc_left;
                end
            elseif (i == 1 && j == ny)
                if (bc_left == Inf)
                    rxp = (cMap(i,j) + cMap(i+1,j))/2;
                    rym = (cMap(i,j) + cMap(i,j-1))/2;

                    G(n,n)   = -(rxp+rym);
                    G(n,nxp) =  rxp;
                    G(n,nym) =  rym;
                else
                    G(n,n) = 1;
                    B(n) = bc_left;
                end
            elseif i == nx && j == 1 % Right side
                if (bc_right == Inf)
                    rxm = (cMap(i,j) + cMap(i-1,j))/2;
                    ryp = (cMap(i,j) + cMap(i,j+1))/2;
                    G(n,n)   = -(rxm+ryp);
                    G(n,nxm) =  rxm;
                    G(n,nyp) =  ryp;
                else
                    G(n,n) = 1;
                    B(n) = bc_right;
                end
            elseif i == nx && j == ny % Right side
                if (bc_right == Inf)
                    rxm = (cMap(i,j) + cMap(i-1,j))/2;
                    rym = (cMap(i,j) + cMap(i,j-1))/2;
                    G(n,n)   = -(rxm+rym);
                    G(n,nxm) =  rxm;
                    G(n,nym) =  rym;
                else
                    G(n,n) = 1;
                    B(n) = bc_right;
                end
            elseif (i == 1) % Left Side
                if (bc_left == Inf)
                    rxp = (cMap(i,j) + cMap(i+1,j))/2;
                    rym = (cMap(i,j) + cMap(i,j-1))/2;
                    ryp = (cMap(i,j) + cMap(i,j+1))/2;

                    G(n,n)   = -(rxp+rym+ryp);
                    G(n,nxp) =  rxp;
                    G(n,nym) =  rym;
                    G(n,nyp) =  ryp;
                else
                    G(n,n) = 1;
                    B(n) = bc_left;
                end
            elseif i == nx % Right side
                if (bc_right == Inf)
                    rxm = (cMap(i,j) + cMap(i-1,j))/2;
                    rym = (cMap(i,j) + cMap(i,j-1))/2;
                    ryp = (cMap(i,j) + cMap(i,j+1))/2;
                    G(n,n)   = -(rxm+rym+ryp);
                    G(n,nxm) =  rxm;
                    G(n,nym) =  rym;
                    G(n,nyp) =  ryp;
                else
                    G(n,n) = 1;
                    B(n) = bc_right;
                end
            elseif j == 1 % Top Side
                if (bc_top == Inf)
                    rxm = (cMap(i,j) + cMap(i-1,j))/2;
                    rxp = (cMap(i,j) + cMap(i+1,j))/2;
                    ryp = (cMap(i,j) + cMap(i,j+1))/2;
                    G(n,n) = -(rxm+rxp+ryp);
                    G(n,nxm) =  rxm;
                    G(n,nxp) =  rxp;
                    G(n,nyp) =  ryp;
                else
                    G(n,n) = 1;
                    B(n) = bc_top;
                end
            elseif j == ny % Bottom Side
                if (bc_bottom == Inf)
                    rxm = (cMap(i,j) + cMap(i-1,j))/2;
                    rxp = (cMap(i,j) + cMap(i+1,j))/2;
                    rym = (cMap(i,j) + cMap(i,j-1))/2;
                    G(n,n) = -(rxm+rxp+rym);
                    G(n,nxm) =  rxm;
                    G(n,nxp) =  rxp;
                    G(n,nym) =  rym;
                else
                    G(n,n) = 1;
                    B(n) = bc_bottom;
                end
            else % Bulk Area
                rxm = (cMap(i,j) + cMap(i-1,j))/2;
                rxp = (cMap(i,j) + cMap(i+1,j))/2;
                rym = (cMap(i,j) + cMap(i,j-1))/2;
                ryp = (cMap(i,j) + cMap(i,j+1))/2;
                
                G(n,n)   = -(rxm+rxp+rym+ryp);
                G(n,nxm) =  rxm;
                G(n,nxp) =  rxp;
                G(n,nym) =  rym;
                G(n,nyp) =  ryp;
            end
        end
    end
    
    V_temp = G\B';
    
    V = zeros(nx,ny,1);
    for i=1:nx
        for j=1:ny
            V(i,j) = V_temp(map(i,j, nx, ny));
        end
    end
end

