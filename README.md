# Single-Server Markovian Queue with Customer Feedback, Time-Homogeneous Partial and Complete Breakdowns, and Cost Optimization Using a Genetic Algorithm

## Description

This repository contains the MATLAB implementation, optimization procedures, and supporting files used for the manuscript:

**"Single-Server Markovian Queue with Customer Feedback, Time-Homogeneous Partial and Complete Breakdowns, and Cost Optimization Using a Genetic Algorithm"**

The repository is provided to improve reproducibility and facilitate further research on queueing systems with customer feedback, partial and complete server breakdowns, and cost optimization.

## Repository Contents

### MATLAB_Code

* `GA_optimization.m` : Main Genetic Algorithm implementation for cost optimization.
* `objective_function.m` : Computes the total expected cost function.
* `constraints_function.m` : Defines the optimization constraints and feasibility conditions.

## Optimization Variables

The Genetic Algorithm optimizes the following decision variable vector:

**X = (μ₁, μ₂, β₁, β₂)**

where:

* **μ₁** : Service rate in the normal active mode
* **μ₂** : Service rate in the partial breakdown mode
* **β₁** : Repair rate from partial breakdown
* **β₂** : Repair rate from complete breakdown

## Customer Feedback

The proposed queueing model incorporates **customer feedback** after service completion.

The parameter

**p** : Probability that a customer feeds back into the system after service completion.

Thus:

* **p** : Feedback probability
* **1 − p** : Probability that a customer leaves the system after service completion

The feedback mechanism is incorporated into the transition structure of the queueing model and consequently affects the steady-state probabilities, system performance measures, and total expected cost.

The MATLAB implementation uses the variable `p` to represent the feedback probability.

## Model Parameters and Notation Used in MATLAB Code

For consistency with the manuscript, the mathematical notation used in the model and the corresponding variable names used in the MATLAB implementation are given below.

| Mathematical notation | MATLAB variable | Description                                          |
| --------------------- | --------------- | ---------------------------------------------------- |
| α₁                    | `a1`            | Rate of partial breakdown                            |
| α₂                    | `a2`            | Rate of complete breakdown                           |
| β₁                    | `b1`            | Repair rate from partial breakdown                   |
| β₂                    | `b2`            | Repair rate from complete breakdown                  |
| μ₁                    | `m1`            | Service rate in the normal active mode               |
| μ₂                    | `m2`            | Service rate in the partial breakdown mode           |
| λ                     | `l`             | Customer arrival rate                                |
| p                     | `p`             | Customer feedback probability                        |
| 1 − p                 | `1-p`           | Probability that a served customer leaves the system |

Thus, the parameters α₁, α₂, β₁, β₂, μ₁, μ₂, λ, and p used in the manuscript correspond to `a1`, `a2`, `b1`, `b2`, `m1`, `m2`, `l`, and `p`, respectively, in the MATLAB program.

## Cost Parameters

The cost parameters used in the mathematical model and their corresponding MATLAB variable names are given below.

| Mathematical notation | MATLAB variable | Description                                                           |
| --------------------- | --------------- | --------------------------------------------------------------------- |
| Cₕ                    | `C1`            | Customer holding cost per customer per unit time                      |
| C𝑤                   | `C2`            | Customer waiting cost (or delay penalty) per customer per unit time   |
| Cₛ₁                   | `C3`            | Service cost per service completion in the normal active mode         |
| Cₛ₂                   | `C4`            | Service cost per service completion in the partial breakdown mode     |
| Cᵣ₁                   | `C5`            | Running/operational cost per unit time in the normal active mode      |
| Cᵣ₂                   | `C6`            | Running/operational cost per unit time in the partial breakdown mode  |
| Cᵣ₃                   | `C7`            | Running/operational cost per unit time in the complete breakdown mode |
| Cᵣₚ₁                  | `C8`            | Repair cost associated with partial breakdown                         |
| Cᵣₚ₂                  | `C9`            | Repair cost associated with complete breakdown                        |

Thus, the cost parameters Cₕ, C𝑤, Cₛ₁, Cₛ₂, Cᵣ₁, Cᵣ₂, Cᵣ₃, Cᵣₚ₁, and Cᵣₚ₂ used in the manuscript correspond to `C1`, `C2`, `C3`, `C4`, `C5`, `C6`, `C7`, `C8`, and `C9`, respectively, in the MATLAB program.

## Optimization Constraints

The Genetic Algorithm performs the optimization subject to the following feasibility conditions:

* **ρ < 1**
* **μ₂ < μ₁**
* **0 ≤ μ₁ ≤ 4.0**
* **0 ≤ μ₂ ≤ 3.5**
* **0 ≤ β₁ ≤ 2.0**
* **0 ≤ β₂ ≤ 2.0**

The feedback probability \(p\) is treated as a model parameter and is specified in the MATLAB implementation according to the numerical experiment.

## Software Requirements

* MATLAB
* Global Optimization Toolbox

The code is intended to be executed using a MATLAB version compatible with the functions used in the implementation.

## Instructions for Running the Code

1. Download or clone the repository.
2. Open MATLAB.
3. Navigate to the `MATLAB_Code` folder.
4. Ensure that all MATLAB files are available in the same working directory.
5. Run the main program:

```matlab
GA_optimization
```

6. The Genetic Algorithm performs the cost optimization subject to the specified constraints.
7. The optimized decision variables and the corresponding objective-function value are generated automatically.

## Reproducibility

The MATLAB files provided in this repository contain the implementation used for the numerical optimization presented in the manuscript.

The `GA_optimization.m` file serves as the main program and calls the objective-function and constraint-function files required for the optimization.

The implementation incorporates:

* Customer arrivals according to the Markovian arrival process assumed in the model.
* Customer feedback with probability \(p\).
* Partial server breakdowns with rate α₁.
* Complete server breakdowns with rate α₂.
* Repair of partial breakdowns with rate β₁.
* Repair of complete breakdowns with rate β₂.
* Service in the normal active mode with rate μ₁.
* Service in the partial breakdown mode with rate μ₂.
* Cost optimization using a Genetic Algorithm.

The notation tables provided above allow readers to directly relate the mathematical symbols used in the manuscript to the variable names implemented in the MATLAB program.

## GitHub Repository

The MATLAB implementation and supporting files are publicly available at:

**https://github.com/manikandanmaths17/Single-Server-Queue-GA-Optimization**

## License

This project is distributed under the MIT License.

## Author

**Manikandan B**

Department of Mathematics
Annamalai University

## Contact

For questions regarding the code or manuscript, please contact the corresponding author.
