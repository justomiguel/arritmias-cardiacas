package genetics.productos;

import genetics.cromosomas.IGen;

public abstract class Producto implements IGen, Cloneable {

    protected int[] materiasPrimas;
    protected double profitValue;
    protected static final int[] restricciones = new int[8];

    public Producto() {
        materiasPrimas = new int[8];
    }

    public int[] getMateriasPrimas() {
        return materiasPrimas;
    }

    public void setMateriasPrimas(int[] materiasPrimas) {
        this.materiasPrimas = materiasPrimas;
    }

    public int[] getRestricciones() {
        return restricciones;
    }

    public double getProfitValue() {
        return profitValue;
    }

    public void setProfitValue(double profitValue) {
        this.profitValue = profitValue;
    }

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }



}
