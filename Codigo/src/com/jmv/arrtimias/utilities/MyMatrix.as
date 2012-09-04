package  com.jmv.arrtimias.utilities
{
	/**
	 * ...
	 * @author Justo Vargas
	 */
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	
	public final class MyMatrix extends Object
	{
		
		public static const opMul:String = "Multiplication";
		public static const opAdd:String = "Addition";
		public static const opSub:String = "Subtract";
		public static const opInv:String = "Inverse";
		public static const opFMX:String = "ToFlashMatrix";
		public static const opFM3:String = "ToFlashMatrix3D";
		
		private var data:Vector.<*>;
		private var W:uint;
		private var H:uint;
		
		public var newLine:Boolean = true;
		
		//Constructor. Takes in width, height, and an array of data. You do not have to fill the Matrix early, but you can't over-flow it.
		public function MyMatrix ( width:uint, height:uint, ... dat )
		{
			
			data = new Vector.<*> ( width * height, true );
			
			W = width;
			H = height;
			
			if ( dat.length > W * H )
				throw new Error ( "More data provided than fits in Matrix.", 0 );
			
			for ( var n:uint = 0; n < dat.length; n ++ )
				data [ n ] = dat [ n ];
			
		};
		
		//Set a specific element to a value, in X-Y form, top left being the origin, going down and to the right.
		public function setElement ( x:uint, y:uint, value:* ) : void
		{
			
			if ( x >= W || y >= H )
				throw new Error ( "The coordinance ( " + x + ", " + y + " ) is out of the Matrix bounds.", 1 );
			
			data [ x + y * W ] = value;
			
		};
		
		
		//Get the value of a specific element, similarly to setElement.
		public function getElement ( x:uint, y:uint ) : *
		{
			
			return data [ x + y * W ];
			
		};
		
		//Width getter
		public function get width () : uint
		{
			
			return W;
			
		};
		
		//Height getter
		public function get height () : uint
		{
			
			return H;
			
		};
		
		//Returns the raw number data in an array.
		public function getRawData () : Vector.<*>
		{
			
			return data;
			
		};
		
		public function toString () : String
		{
			
			var out:String = ( newLine ) ? '' : '[ ';
			var maxL:Vector.<uint> = new Vector.<uint> ( W, true );
			
			var qx:uint;
			var sp:String;
			var sa:String;
			
			for ( var n:uint = 0; n < W * H; n ++ )
			{
				
				qx = n % W;
				maxL [ qx ] = Math.max ( maxL [ qx ], data [ n ].toString ().length );
				
			}
			
			for ( var y:uint = 0; y < H; y ++ )
			for ( var x:uint = 0; x < W; x ++ )
			{
				
				sp = '';
				sa = data [ x + y * W ].toString ();
				
				while ( sa.length < maxL [ x ] && newLine )
					sa = ' ' + sa;
				
				if ( x == 0 )
					out += '[ ';
				
				out += sa;
				
				if ( x < W - 1 )
					out += ', ';
				else
				{
					
					out += ' ]';
						if ( y < H - 1 )
							out += ( newLine ) ? '\n' : ' ';
				
				}
				
			}
			
			out += ( newLine ) ? '' : ' ]';
			
			var t:String = '';
			
			if ( out.indexOf ( "\n" ) != 0 )
			{
				
				var u:uint = 0;
				while ( u ++ < out.indexOf ( "\n" ) )
					t += '-';
				
			}
			else
			{
				
				var g:uint = 0;
				while ( g ++ < out.length )
					t += '-';
				
			}
			
			if ( newLine )
				out = "Matrix:\n" + t + '\n' + out + '\n' + t;
			
			return out;
			
		};
		
		public function disposeData():void 
		{
			data = null;
		}
		
		
	};
	

}