function [y]=D1steady_optimal_function(Tc,ff,wf,E,fe,alpha,epsilon,xm,theta,tau_star,rho_star)
    t=tau_star;
    rho=rho_star;
    H2=(ff-1)^(1/(epsilon-1))*(((1-t)/(1-rho))*(wf*((1-rho)/(1-t))*(1-theta)^E)^(1-epsilon)-1)^(-1/(epsilon-1));
    xi=(alpha/(alpha+1-epsilon))*(1-H2^(-alpha))^(-1)*(1-H2^(epsilon-1-alpha));
    xf=(alpha/(alpha+1-epsilon))*H2^(epsilon-1);
    factor=((1/wf)*((1-t)/(1-rho))*(1/(1-theta)^E))^(1-epsilon);
    xt=(alpha/(alpha+1-epsilon))*(factor*(1-H2^(epsilon-1-alpha))+H2^(epsilon-1-alpha));
    xt1=(alpha/(alpha+1-epsilon))*((1-rho)*factor*(1-H2^(epsilon-1-alpha))+(1-t)*H2^(epsilon-1-alpha));
    factor2=(factor^(-1)*xt1/(1-rho))-(1-H2^(-alpha))-H2^(-alpha)*ff;
    x1=xm*(factor2/fe)^(1/alpha);
    x2=H2*x1;
    rf1=(factor^(-1))*(xt)*epsilon/(1-rho);
    rf2=epsilon*(xt/xt1)*(fe*(x1/xm)^(alpha)+(1-H2^(-alpha))+H2^(-alpha)*ff);
    
    %
    a1=t*H2^(-alpha)*(xf/xt)+H2^(-alpha)*ff*(1-rho)*(1/(epsilon*xt))*(factor)+rho*factor*(1-H2^(-alpha))*(xi/xt);
    Q=(1/(1-a1))*Tc;
    kt=(t*H2^(-alpha)*(xf/xt)+H2^(-alpha)*ff*(1-rho)*(1/(epsilon*xt))*(factor))*Q;
    l2=rho*factor*(1-H2^(-alpha))*(xi/xt)*Q;
    T=t*Q*H2^(-alpha)*xf/xt;
    
    p=(epsilon/(Q*(1-rho)))^(1/(epsilon))*(((epsilon-1)*(1-rho)*((1-theta)*kt)^E)/(epsilon))^((1-epsilon)/epsilon)*x1^((1-epsilon)/epsilon);
    m=(p*Q/epsilon)*factor*(1-rho)*(1/xt);
    
    k3=T+(H2^(-alpha)*ff*m/p);
    
    Qt=(epsilon/((1-rho)*p^(epsilon)))*(((epsilon-1)*(1-rho)*((1-theta)*k3)^E)/(epsilon))^(1-epsilon)*x1^(1-epsilon);
    
    %beneficios
    
    pi_ii=((1-rho)/epsilon)*((epsilon)/((epsilon-1)*(1-rho)*((1-theta)*k3)^(E)))^(1-epsilon)*(Q/p^(-epsilon))*x1^(epsilon-1)-1;
    pi_f=((1-t)/epsilon)*((epsilon*wf)/((epsilon-1)*(1-t)*(k3)^(E)))^(1-epsilon)*(Q/p^(-epsilon))*x2^(epsilon-1)-ff;
    pi_if=((1-rho)/epsilon)*((epsilon)/((epsilon-1)*(1-rho)*((1-theta)*k3)^(E)))^(1-epsilon)*(Q/p^(-epsilon))*x2^(epsilon-1)-1;
    
    % yti y nti
    
    factorx=((1/wf)*((1-t)/(1-rho))*(1/(1-theta)^E));
    yi=factorx^(1-epsilon)*((1-H2^(-alpha))/(H2^(-alpha)))*xi/xf;
    ni=(1/(1-theta)^E)*factorx^(-epsilon)*((1-H2^(-alpha))/(H2^(-alpha)))*xi/xf;
    
    % guardando parámetros y valores de estado estacionario (re-etiquetados, conforme a los del dynare)
    Fs=factor;
    hs=H2;
    xis=xi^(1/(epsilon-1))*x1;
    xfs=xf^(1/(epsilon-1))*x1;
    xts=xt^(1/(epsilon-1))*x1;
    xt1s=xt1^(1/(epsilon-1))*x1;
    x1s=x1;
    ps=p;
    ms=m;
    Ts=T;
    ls=l2;
    qs=Q;
    ks=k3;
    is=1-H2^(-alpha);
    x2s=x2;
    cs=Tc;
    y=[ff,wf,theta,epsilon,alpha,t,rho,E,fe,xm,Fs,hs,xis,xfs,xts,xt1s,x1s,ps,ms,Ts,ls,qs,ks,is,x2s,cs];
    end