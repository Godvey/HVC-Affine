# *Enhanced Affine Formation Maneuver Control Using Historical Velocity (HVC) Simulation Codes*

## Information 

### Author: Wei Yu & Peng Yi
### Update Date: 2023.07.30
### Email: yuwei26@mail2.sysu.edu.cn
### Requirements
- Matlab 2020b and above
- Simulink 2020b and above

## Introduction
This is the code for nine unicycles to realize affine formation simulation，and it has been tested in matlab R2020b.

## Code Structure

<img width="314" alt="image" src="https://github.com/Lovely-XPP/HVC-Affine/assets/66028151/e1c9b288-3c34-4c40-bb57-ec4fd199debb">


- `affine_single_intergrator.slx` - Main programme of theoretical simulation by Simulink.
- `affine_single_intergrator_ex.slx` - Main programme of  experiment simulation by Simulink.
- `run_by_script.m` - A Matlab script to easyly run simulation and demonstrate results including essential figures and cohesiveness.
- `Initial_Parameters.m` - A script to initialize parameters for simulation.
- `fcn_StressMatrix.m` - A script to calculate Stress Matrix by Shiyu, Zhao.
- `calculate_cohesiveness.m` - A script to calculate cohesiveness of simulation results.
- `data` - Data of experiments.
- `FigureUtility` - Functions of visualizing simulation results including trajectory, norm error, etc.
- `SimulationResults` - Save folder for simulation results for experiment simulation mode.


## Usage
It is strongly recommended to use `run_by_script.m` for simulation. Detailed Parameters are as follow:

### Parameters
#### `run_by_script.m`

| Parameters           | Descriptions                                              | Type         | Example                         | Notes                                                        |
| -------------------- | --------------------------------------------------------- | ------------ | ------------------------------- | ------------------------------------------------------------ |
| `run_mode`           | 1 for theoretical simulation, 2 for experiment simulation | int          | `1`                             |                                                              |
| `fig_from_data`      | If figure from `.mat` file,                               | bool         | `true`                          | **Only support experiment simulation mode**                  |
| `data_dir`           | Figure data dir, work with `fig_from_data`                | str          | `"./SimulationResults/data.mat"` |                                                              |
| `delay`              | Historical information delay, $\tau$                      | double       | `0.01`                          |                                                              |
| `cmd_sample`         | Control period                                            | double       | `0.1`                           | **Only support experiment simulation mode**                  |
| `kalpha`             | Controller parameter $k_\alpha$                           | double       | `0.5`                           |                                                              |
| `kbeta`              | Controller parameter $k_\beta$                            | double       | `0.5`                           |                                                              |
| `Tv, Kv`             | Actuator first-order model parameters                     | double       | `0.16, 0.987/0.16`              | $\dfrac{Kv}{s + Tv}$                                         |
| `kptheta`            | Angle controller for experiment car                       | double       | `100`                           | $\omega^d = k_\theta(\theta^d - \theta)$                     |
| `R, L`              | Parameters of car kinematics                              | double       | `3.2e-3, 10.5e-3`               |                                                              |
| `noise_v, noise_p`   | Noise magnitude for velocity and position feedback        | list[double] | `normrnd(0.001, 0.03,[1 6]);`   | Different followers have different noise                     |
| `noise_vT, noise_pT` | Noise sample time for velocity and position feedback      | double       | `0.1, 3`                        |                                                              |
| `seed_v, seed_p`     | Noise seed time for velocity and position feedback        | list[double] | `floor(rand()*10000000)`        | Different followers have different noise                     |


### `Initial_Parameters.m`

| Parameters        | Descriptions                                 | Type         | Example                                                    | Notes                   |
| ----------------- | -------------------------------------------- | ------------ | ---------------------------------------------------------- | ----------------------- |
| `vel_x`           | Leader velocity of X-channel                 | double       | `0.1`                                                      |                         |
| `vel_y, w_y, c_y` | Leader sine velocity of Y-channel            | double       | `0.5, 0.5, 0`                                              | $v_y=A\sin(wt) + c$     |
| `leaderNum`       | Leaders count                                | int          | `3`                                                        | **Recommended use `3`** |
| `P`               | the configuration of desired formation       | List[double] | `2*[2 0;1 1; 1 -1;0 1.2;0 -1.2;-1 1;-1 -1;-2 0.5;-2 -0.5]` |                         |
| `P0`              | the initial positions of  agents             | List[double] | `[2 0;1 1; 1 -1;1 2.2;-1 -2.2;1 3;-3 -3;1 3.5;-5 -3.5]`    |                         |
| `neighborMat`     | Undirected adjacent matrix for the formation | List[double] |                                                            |                         |
