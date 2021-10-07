# distinct-species
## Scope
This tool provides different algorithms to estimate the number of distinct species in a population.  
It includes some estimators from the literature and a new estimator based on a bayesian nonparametric approach.  
The focus is mainly on populations coming from a Power Law distribution <img src="https://render.githubusercontent.com/render/math?math=Z_{D,\theta}"> with support parameter D and skew parameter <img src="https://render.githubusercontent.com/render/math?math=\theta">. This distribution models effectively a large number of real world databases, in particular many arising from human activity.  

We followed the steps below:
1. Generate different databases from a Power Law distribution with support D = 50000 and <img src="https://render.githubusercontent.com/render/math?math=\theta"> varying from 0 (uniform) to 1.4 (high skewed)
2. From each database, draw samples of size 5%, 10% and 20% of the database. For each sample size we draw 100 samples
3. Compute the estimators for each sample. For each <img src="https://render.githubusercontent.com/render/math?math=\theta"> and each sample size, average over the 100 samples and compute confidence bounds at 1 std 

## Contents
The repository contains the following:
1. *00_main*: the main scripts to run the steps listed above. It includes   
    * `distinct_species_estimators` mainly runs the estimators presented in *Haas et al.(1995)*
    * `PYvsGT_estimators` runs the Good-Toulmin estimator and compares the results with our new estimator based on the nonparametric approach (Pitman-Yor)
    * `zipfian_support_estimators` runs the estimators presented in *Charikar et al.(2000)*. The main difference from `distinct_species_estimators` is that these algorithms provide an estimation of the support D ot the distribution rather than the number of distinct values in the population
    * *data* folder contains data and results produced by the 3 scripts above
    * *plots* folder contains pdf plots of the results produced by the 3 scripts above
2. *01_estimators*: contains the estimators that are executed by *00_main*
3. *02_support_functions*: contains support function that are used bu the estimators, such as `par_estimator` and `differential_evolution` that are used for estimating the parameter <img src="https://render.githubusercontent.com/render/math?math=\hat{\theta}">, or `zipf_sample` that is used to draw a random sample from a Zipfian distribution.
4. *03_media*: (WIP) contains some scripts to run the animation of the differential evolution optimization method (just for fun)

## References
The algorithms presented are mainly based on  
* HAAS, P.J. NAUGHTON, J.F. SESHADRI, S. and STOKES, L. (1995).
Sampling-Based Estimation of the Number of Distinct Values of an Attribute. *Proceedings of the 21th International Conference on Very Large
Data Bases*, 311–322.
* CHARIKAR, M. CHAUDHURI, S. MOTWANI, R. and NARASAYYA, V.
(2000). Towards Estimation Error Guarantees for Distinct Values. *Proceedings of the Nineteenth ACM SIGMOD-SIGACT-SIGART Symposium
on Principles of Database Systems*, 268–279.
