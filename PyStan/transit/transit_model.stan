data  {
        int<lower=0> N; // number of data points
    	real<lower=0> t[N]; // time at each data point
    	real<lower=0> L[N]; // luminosity at each data point
}

parameters  {
    real<lower=25,upper=35> A;
    real<lower=5,upper=15> B;
    real<lower=50,upper=90> t1;
    real<lower=110,upper=150> t2;
    real<lower=0> sigma;
}

transformed parameters {
		     
}

model  {

    A ~ uniform(25,35);
    B ~ uniform(5,15);
    t1 ~ uniform(50,90);
    t2 ~ uniform(110,150);
    sigma ~ normal(0.5,0.1);

    for (m in 1:N) {
    	   if (t[m]<t1 || t[m]>t2)
    	      L[m] ~ normal(A,sigma);
	   else 
	      L[m] ~ normal(B,sigma);}
	   	  
}

generated quantities {
	  real L_pred[N];

	  for (m in 1:N)
              if (t[m]<t1 || t[m]>t2)
              	 L_pred[m] <- normal_rng(A,sigma);
              else
	 	 L_pred[m] <- normal_rng(B,sigma);
}