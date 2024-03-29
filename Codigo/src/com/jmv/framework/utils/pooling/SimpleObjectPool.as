package com.jmv.framework.utils.pooling 
{
	/**
	 * ...
	 * @author Miguel
	 */
	public class SimpleObjectPool
	{
		
		public var minSize : int;
                public var size : int = 0;

                public var create : Function;
                public var clean : Function;
                public var length : int = 0;

                private var list : Array = [];
                private var disposed : Boolean = false;

                public function SimpleObjectPool(create : Function, clean : Function = null, minSize : int = 50) {
                        this.create = create;
                        this.clean = clean;
                        this.minSize = minSize;
                        
                        for(var i : int = 0;i < minSize; i++) add();
                }
                
                public function add() : void {
                        list[length++] = create();
                        size++;
                }

                public function checkOut() : * {
                        if(length == 0) {
                                size++;
                                return create();
                        }
                        
                        return list[--length];
                }

                public function checkIn(item : *) : void {
                        if(clean != null) clean(item);
                        list[length++] = item;
                }

                public function dispose() : void {
                        if(disposed) return;
                        
                        disposed = true;
                        
                        create = null;
                        clean = null;
                        list = null;
                }
		
	}

}