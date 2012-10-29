package genetics.cromosomas;

public interface ICromosoma {
	
	public Double getFitnessValue();

	public void setFitnessValue(double fitnessValue);
	
	public void mutate();
	
	public ICromosoma doCruza(ICromosoma cromosoma);
	
	
	
}
