// RangeNormalizer class
// Since different platforms return different values for some functions this class will help us return values in a range of 0-1
// An example of this problem is in the returns of maxim getAveragePower() function which in java-mode returns 0-1 but in javascrip mode return very different values
// Coded by Nicolai R. Tellefsen

class RangeNormalizer {
  private Float max;
  private Float min;
  private Float value;
  
  RangeNormalizer(float _value) {
    this.setValue(_value);
  }
  RangeNormalizer() {
    this.max = null;
    this.min = null;
    this.value = null;
    this.setValue(null);
  }
  
  public void setValue(Float _value) {
    if(_value == null) {
      return; 
    }
    
    if(this.max == null) {
      this.max = _value;
    }
    if(this.min == null) {
      this.min = _value; 
    }
    if(_value > this.max) {
      this.max = _value; 
    }
    if(_value < this.min) {
      this.min = _value; 
    }
    
    this.value = _value;
  }
  
  public float getMin() {
    if(this.min == null) {
      return 0; 
    }
    return this.min;
  }
  
  public float getMax() {
    if(this.max == null) {
      return 0; 
    }
    return this.max;
  }
  
  public float getValue() {
    if(this.value == null) {
      return 0; 
    }
    return this.value;
  }
  
  public float getRatio() {
    if(this.value == null || this.max == null || this.min == null) {
      return 0; 
    }
    return (this.value-this.min)/(this.max-this.min);
  }
  
}
