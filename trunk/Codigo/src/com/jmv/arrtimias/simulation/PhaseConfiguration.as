package com.jmv.arrtimias.simulation 
{
	/**
	 * ...
	 * @author matix
	 */
	public class PhaseConfiguration 
	{
		private var p_relative:Vector.<Number>;
		private var p_absolute:Number;
		
		public function PhaseConfiguration(absolute:Number, relative:Vector.<Number>) 
		{
			this.p_relative = relative;
			this.p_absolute = absolute;	
		}
		
		public function get absolute():Number 
		{
			return p_absolute;
		}
		
		public function get relative():Vector.<Number> 
		{
			return p_relative;
		}
		
	}

}