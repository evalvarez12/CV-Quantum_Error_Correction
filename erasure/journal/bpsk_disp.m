function [delta2] = bpsk_disp(T1, T2, T3, sigma, V, eps, eta)
    ber = 1e-9;

    V2 = sqrt(V^2 -1);

    Tp = (sqrt(T1) + sqrt(T2))/2;
    Tm = (sqrt(T1) - sqrt(T2))/2;

    a = eta*(V*(Tp^2/2 + T3/2) - 2*V2*Tp*sqrt(T3)/2);
    b = eta*Tm^2/2;
    c = 1 + eta*(eps - T1/4 - T2/4 - T3/2);
    d = eta*Tm^2;

    sig2_snr = d*sigma + (a + b + c);
    delta_a =  eta*Tp^2;



    % Return |delta|^2 value 
    delta2 = sig2_snr/delta_a * erfcinv(2*ber);


end