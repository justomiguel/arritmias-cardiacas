package  
{
	import com.jmv.arrtimias.simulation.Cell;
	import com.jmv.arrtimias.simulation.CellNeighborhood;
	import com.jmv.arrtimias.simulation.PhaseConfiguration;
	import com.jmv.arrtimias.simulation.SimulationEvent;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author matix
	 */
	public class SimulationTest extends Sprite 
	{
		
		public function SimulationTest() 
		{
			var cell01:Cell = new Cell(new PhaseConfiguration(1000, new <Number>[2000, 3000, 4000]),[{direction:"right", delay:2000}]);
			var cell02:Cell = new Cell(new PhaseConfiguration(1000, new <Number>[2000, 3000, 4000]),[{direction:"bottom", delay:2000}]);
			var cell03:Cell = new Cell(new PhaseConfiguration(1000, new <Number>[2000, 3000, 4000]),[{direction:"left", delay:2000}]);
			var cell04:Cell = new Cell(new PhaseConfiguration(1000, new < Number > [2000, 3000, 4000]), [ { direction:"top", delay:2000 } ]);
			
			cell01.neighborhood = new CellNeighborhood( {right:cell02, bottom:cell03, bottomRight:cell04} );
			cell02.neighborhood = new CellNeighborhood( {left:cell01, bottomLeft:cell03, bottom:cell04 });
			cell03.neighborhood = new CellNeighborhood( {top:cell01, topRight:cell02, right:cell04} );
			cell04.neighborhood = new CellNeighborhood( { topLeft:cell01, top:cell02, left:cell03 } );
			
			var cells:Array = [cell01, cell02, cell03, cell04];
			for (var index:int = 0; index < cells.length; index++ ) {
				var cell:Cell = cells[index];
				cell.addEventListener(SimulationEvent.PHASE_COMPLETED_EVENT, function(e:SimulationEvent):void {
					trace("cell", cells.indexOf(e.currentTarget), "->", cell.currentPhase.name);
				});
			}
			
			trace("Started")
			cell01.startPropagation();
			
		}
		
	}

}