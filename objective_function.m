function f = objective_function(x)

l=3.3;
t=0.05;
q=1-t;
m1=q*x(1);
m2=q*x(2);
a1=0.3;
a2=0.5;
b1=x(3);
b2=x(4);
C1=10;
C2=5;
C3=25;
C4=35;
C5=15;
C6=25;
C7=5;
C8=100;
C9=500;
C10=25;

P=(l*(b2*(a2+b1)+(a1*(a2+b2))))/((b2*m1*(a2+b1))+(a1*b2*m2));
A=-(l^3);
B=(l*l*m2)+(l*l*m1)+(2*(l^3))+((l^2)*b2)+(l*l*a2)+(l*l*b1)+(l*l*a1);
C=-((l*m1*m2)+(l*l*m2)+(l*m2*a1)+(l*l*m1)+(l*a2*m1)+(l*m1*b1)+((l+b2)*((l*m2)+(l*m1)+(l^2)+(l*a2)+(l*a1)+(l*b1)))+(l*a1*a2));
D=(l*m1*m2)+((l+b2)*((m1*m2)+(l*m2)+(m2*a1)+(l*m1)+(m1*a2)+(m1*b1)));
E=-((l+b2)*m1*m2);
coeff = [A B C D E];



n = length(coeff);
poly_str = '';
for i = 1:n
    ci = coeff(i);
    p  = n - i;
    if abs(ci) < 1e-12, continue; end

    % Sign
    if isempty(poly_str)
        signStr = '';
        if ci < 0, signStr = '-'; ci = -ci; end
    else
        if ci > 0, signStr = ' + ';
        else,      signStr = ' - '; ci = -ci;
        end
    end

    % Coefficient
    if p >= 1 && abs(ci - 1) < 1e-12
        coeffStr = '';
    else
        coeffStr = num2str(ci);
    end

    % Power part
    if p > 1
        powStr = ['y^' num2str(p)];
    elseif p == 1
        powStr = 'y';
    else
        powStr = '';
    end

    poly_str = [poly_str signStr coeffStr powStr];
end

% ---- Solve roots ----
tol = 1e-12;
if abs(B) < tol && abs(D) < tol
    % True biquadratic: a*y^4 + c*y^2 + e
    t_roots = roots([A C E]);   % quadratic in t = y^2
    r = [];
    for k = 1:numel(t_roots)
        tk = t_roots(k);
        r = [r; sqrt(tk); -sqrt(tk)]; %#ok<AGROW>
    end
    r = uniquetol(r,1e-10);
else
    % General quartic
    r = roots(coeff);
end

% ---- Pick root(s) between 0 and 1 ----
real_roots = r(abs(imag(r)) < 1e-10);    % keep only real roots
y = real_roots(real_roots >= 0 & real_roots <= 1); 



K=(m1*(((y-1)*l)-b2)*(((y-1)*(m2-(l*y)))+(y*a2)+(y*b1)))/((m2*y*b1*(((1-y)*l)+b2))+(m2*y*a2*b2));

P10=(((b2*m1*(a2+b1))+(a1*b2*m2))*(1-P))/(((a2+b1)*b2)+((a2+b2)*a1)*((m2*K)+m1));
P20=(K*P10);
P30=(a2*P20)/(l+b2);

Q1=((a2+b1)*b2)/(((a2+b1)*b2)+((a2+b2)*a1));
Q2=(a1*b2)/(((a2+b1)*b2)+((a2+b2)*a1));
Q3=(a1*a2)/(((a2+b1)*b2)+((a2+b2)*a1));

M1=(((l*m1*m2*a2*b1*b2*K)-(l*l*m2*a2*b1*b2*K)+(l*l*m2*a1*a2*b1*K)+(l*m2*a2*a2*b2*b2*K)+(2*l*m2*a2*b1*b2*b2*K)+(l*m1*m2*a2*a2*b2*K)+(l*m1*m2*a2*b2*b2*K)+(l*m2*m2*a2*b2*b2*K)+(l*m2*a1*a2*b2*b2*K)+(l*m2*m2*a1*a2*b2*K)-(l*l*m2*a2*a2*b2*K)-(l*l*m2*a2*b2*b2*K)-(m1*m2*m2*a2*b2*b2*K)-(l*l*m2*a1*a2*b2*K)+(l*m2*b1*b1*b2*b2*K)+(l*m1*m2*b1*b2*b2*K)+(l*m2*m2*b1*b2*b2*K)+(l*m2*a1*b1*b2*b2*K)-(l*l*m2*b1*b2*b2*K)-(m1*m2*m2*b1*b2*b2*K)+(l*m2*a1*a2*a2*b2*K)+(l*m2*a1*a2*b1*b2*K)-(l*m1*m2*a1*a2*b2)+(l*l*m1*a1*a2*b2)+(l*l*m1*a1*a2*a2)+(l*l*m1*a1*a2*b1)+(m1*m1*m2*a2*b2*b2)+(m1*m2*m2*a1*b2*b2)-(2*l*m1*m2*a1*b2*b2)+(l*l*m1*a1*b2*b2)+(l*m1*a2*a2*b2*b2)+(l*m1*a2*b1*b2*b2)+(l*m1*a1*a2*b2*b2)-(m1*m1*m2*a2*b2*b2)+(l*m1*a2*b1*b2*b2)+(l*m1*b1*b1*b2*b2)+(l*m1*a1*b1*b2*b2)+(l*m1*a1*a2*a2*b2)+(l*m1*a1*a2*b1*b2))*P10)/(((m1+a2+b2)+(m1*b1*b2)-(l*a2*b2)-(l*b1*b2)+(m2*a1*b2)-(l*a1*b2)-(l*a1*a2))^2);
M2=((a1*M1)+(m2*P20)+((l-m2)*Q2))/(a2+b1);
M3=((a2/b2)*M2)+((l/b2)*Q3);
Q10=Q1-P10;
Q20=Q2-P20;
Q30=Q3-P30;
Pb=Q10+Q20+Q30;
M=M1+M2+M3;
Mq=M-Pb;
Wq=(Mq/l);

f=(C1*M)+(C2*Wq)+(C3*m1*Q10)+(C4*m2*Q20)+(C5*Q1)+(C6*Q2)+(C7*Q3)+(C8*b1*Q2)+(C9*b2*Q3)+(C10*t*(m1*Q1 + m2*Q2));
end