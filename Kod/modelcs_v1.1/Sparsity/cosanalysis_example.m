% cosanalysis_example.m
%
% Created: oct 2010.
% email: chinmay@rice.edu

clear, close all, clc
path(path,'../Utils')

N = 512; % signal length
K = 5; % analysis domain sparsity
M = 6*(2*K); % number of measurements

iter = 50; % number of Cosamp iterations

% compute coherent analysis basis

h =zeros(N,1); h(1:3) = [-1; 2; -1];
W = zeros(N); 
for ii=1:N
    W(:,ii) = circshift(h,ii-1);
end
W(1:2,N-2:N) = 0;
% generate signal
maxOrder = 3; breakpoints = K-1;
x = genPWpoly(N,maxOrder,breakpoints);
x(1:10) = 0;
s = W*x;

% figure, subplot(211),plot(x)
% subplot(212),plot(s)
% sum(abs(s)>0.01)

% measurements
Phi = (1/sqrt(M))*randn(M,N);
y = Phi*x;
PhiW = Phi*pinv(W);

% reconstruct using cosamp
% [shat, trsh] = cosamp(y,PhiW,(2*K),iter);
% xhat = pinv(W)*shat;
% 10*log10(norm(x)/norm(x-xhat))

[xhat] = cosanalysis(y,Phi,W,(2*K),iter, x);


figure(1), hold on
box on
plot(x,'-','MarkerSize',10)
plot(xhat,'r--','MarkerSize',3)
axisfortex('','','')
legend('Original','Reconstruction')