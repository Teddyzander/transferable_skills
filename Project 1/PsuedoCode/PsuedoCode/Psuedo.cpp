// Define parameters
// Some parameters are not fixed, and have distrubitions 
// eg norm(mean, sd), or uni(lower bound, upper bound)
// -----------------------------------------------------
// Define simulation parameters
// (eg 10000 simulations, time=0,0.00001,...,1)
N = 10000;
steps = 100000;
time = [0, 0.00001, ..., 1]
...

// Define Stratum Corneum layer parameters (layer 1)
SC_d = 1xN vector of norm(25, 2);
SC_rho = 1500;
...

// Define Viable Epidermis layer parameters (layer 2)
VE_d = 1xN vector of norm(75, 8);
VE_rho = 1200;
...

// Define  Langerhan Cell values
LC_depth = SC_d + VE_d - 10;
LC_r = 4;
...

// Define particle parameters
gold_r = 1xN vector of uni(0.5, 2.5);
v_0 = 1xN vector of norm(500, 50);
...

// Define functions for each layer, one for velocity and one for depth of each step
// depth at time t for particle in Stratum Corneum with initial speed v
SC_x(t, v);
// velocity at time t for particle in Sratum Corneum with initial speed v
SC_v(t, v); 
// depth at time t for particle in viable epidermis with initial speed v
VE_x(t, v); 

// Set up N x steps matrix to store all data inside (preallocate memory)
data = N x steps vector of zeroes;

// simulate a particle
for i in 1:N
{
	// set up a flag to dictate which layer we are in
	layer_2 = false;
	//allocate some number for layer 2 entry speed
	v_1 = 0;
	// step through time for this simulation
	for j in 2:steps
	{
		// check which layer we are in
		// if previous depth is greaterthan/equal to depth of SC
		if data(i, j-1) greater than or equal to SC_d[i];
		{
			// we are in layer 2, so check if this is first entry
			if layer_2 is false
			{
				// this is our first entry, so set flag to "true"
				layer_2 = true;
				// calculate entry velocity for layer 2
				v_1 = SC_v(time[j - 1]);
			}
			// calculate current depth using layer 2 function
			data(i, j) = VE_x(time[j], v_1);
		}
		else
			// we are still in layer 1, so use layer 1 equation for current depth
			data(i, j) = SC_x(time[j], v_0[i])
	}
}

// Plot the results using data matrix


	

