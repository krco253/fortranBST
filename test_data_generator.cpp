/*****************************
 * Test Data Generator
 * Author: Kelsey Cole
 * Compile with: g++ test_data_generator.cpp -o generate_data 
 ****************************/

#include <random>
#include <iostream>

const int LOWER = -250;
const int UPPER = 250;
const int NUM_NODES = 225;
const int PROBECOUNT = 20;

int main()
{
	std::random_device rand_dev;
	std::uniform_int_distribution<int> range(LOWER,UPPER);
	std::cout << NUM_NODES << std::endl;
	for(int i =0; i < NUM_NODES; i++)
	{
		int random_node = range(rand_dev);
		std::cout << random_node << std::endl;

	} 

	std::cout << std::endl;
	std::cout << PROBECOUNT << std::endl;
	for(int i = 0; i < PROBECOUNT; i++)
	{
		int random_query = range(rand_dev);
		std::cout << random_query << std::endl;
	}
	return 0;
}
