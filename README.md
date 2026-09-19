# Weighted Centroid Localization (WCL) in Cell-Free Massive MIMO Networks

[![MATLAB](https://img.shields.io/badge/MATLAB-R2022b%2B-blue.svg)](https://www.mathworks.com/products/matlab.html)
[![Domain: Wireless Communications / 6G](https://img.shields.io/badge/Domain-Wireless%20%26%206G-green.svg)](https://en.wikipedia.org/wiki/6G)
[![Thesis: Bachelor Degree](https://img.shields.io/badge/Thesis-B.Sc.%20Electronic%20Engineering-red.svg)](https://www.unibo.it/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Performance analysis and Monte Carlo numerical evaluation of the **Weighted Centroid Localization (WCL)** algorithm in **Cell-Free Massive MIMO** wireless networks for next-generation (6G) positioning. 

Developed as a Bachelor’s Thesis in Electronic Engineering at **Alma Mater Studiorum – Università di Bologna** (Department of Computer Science and Engineering, Campus of Cesena) under the supervision of **Prof. Ing. Enrico Testi**.

---

## Theoretical Overview & Network Model

Cell-Free Massive MIMO eliminates traditional cellular cell boundaries by deploying a dense, distributed set of Access Points (APs) connected to a Central Processing Unit (CPU) via fronthaul links, serving users via coherent spatial multiplexing.

### 1. Spatial Deployment & Propagation Modeling
- **Spatial Distribution:** APs are deployed on $\mathbb{R}^2$ according to a homogeneous Poisson Point Process (PPP) with spatial density $\lambda \in [0.02, 0.20]\text{ APs/m}^2$.
- **Path-Loss Law:** Non-singular distance-dependent power attenuation governed by:
  $$P_R^U(r_i) = \frac{P_T^{AP}}{\mathcal{L}_0 (1 + r_i^\alpha)} \phi_i$$
  where $\mathcal{L}_0 = 45\text{ dB}$ (reference path loss at $1\text{ m}$), $\alpha \in \{2, 3\}$ is the path-loss exponent, and $\phi_i = e^{\sigma_s g_i}$ represents log-normal shadow fading with intensity $\sigma_{s,dB} \in [0, 6]\text{ dB}$.
- **Marked Inhomogeneous PPP:** Active APs are dynamically selected via power-thresholding ($\Omega_a = \{i : P_R^U(r_i) \ge P_{th}\}$ with $P_{th} = -60\text{ dBm}$), forming an inhomogeneous Marked PPP based on user proximity.

### 2. Downlink Beacon-based Localization (DBL)
The terminal estimates its two-dimensional position $\hat{l}_u = [\hat{x}_u, \hat{y}_u]^T$ via synchronous orthogonal beacon measurements:
$$\hat{l}_u = \frac{\sum_{i \in \Omega_a} w_i l_i \epsilon_i}{\sum_{i \in \Omega_a} w_i \epsilon_i}, \quad w_i = [P_R^U(r_i)]^\beta$$
where $\beta > 0$ is a non-linear weighting exponent tuned to balance nearby versus distant anchor contributions.

---

## Key Findings & Performance Benchmarks

- **Density Scaling & Asymptotic Convergence:** Positioning Mean Squared Error (MSE) exhibits steep power-law decay as AP density scales. Under moderate density ($\lambda = 0.06\text{ APs/m}^2$, $\sigma_{s,dB} = 0\text{ dB}$), the algorithm achieves coarse positioning errors below $1\text{ m}^2$.
- **Dual DBL vs. UPL Equivalence:** Monte Carlo simulations confirm strict numerical equivalence between Downlink Beacon-based Localization (DBL) and Uplink Pilot-based Localization (UPL), proving algorithm consistency irrespective of link direction.
- **Shadowing Mitigation via $\beta$ Optimization:** In heavy fading regimes ($\sigma_{s,dB} = 4\text{ dB}$), tuning the weighting parameter to $\beta = 1.0$ halves the positioning MSE compared to lower weights ($1.6\text{ m}^2 \rightarrow 0.7\text{ m}^2$).
- **Parametric Robustness:** The optimal weighting parameter $\beta^*$ remains quasi-invariant across changing AP spatial densities ($\lambda = 0.12\text{ APs/m}^2$ vs. $\lambda = 0.20\text{ APs/m}^2$), simplifying practical calibration in heterogeneous 6G topologies.

---

## Repository Structure

```text
├── docs/
│   └── Tesi_Bucaletti_Lorenzo.pdf      # Complete B.Sc. thesis monograph (in Italian)
│
├── src/
│   ├── wclfunc_v3.m                    # Core Monte Carlo simulator & WCL estimator
│   ├── LorenzoBucaletti_WCL_MSEb.m     # MSE vs. weighting factor beta parametric sweep
│   ├── BucalettiLorenzo_WCL_CDF.m      # Empirical CDF estimation for error (E) and SE
│   ├── BucalettiLorenzo_WCL_MSE.m      # MSE vs. AP density lambda (alpha=2, beta=0.8)
│   └── BucalettiLorenzo_WCL_MSE2.m     # MSE vs. AP density lambda (alpha=3, beta=0.4)
│
├── .gitignore
├── LICENSE
└── README.md
