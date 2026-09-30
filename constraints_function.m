function [c, ceq] = constraints_function(x)

l=3.3;
t=0.05;
q=1-t;
m1=q*x(1);
m2=q*x(2);
a1=0.3;
a2=0.5;
b1=x(3);
b2=x(4);

P=(l*(b2*(a2+b1)+(a1*(a2+b2))))/((b2*m1*(a2+b1))+(a1*b2*m2));
c1=P-1;
c2=m2-m1;
c = [c1; c2];
ceq = []; % No equality constraints
end
