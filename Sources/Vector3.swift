import Foundation

struct Vector3 : CustomStringConvertible
{
	var x : Double
	var y : Double
	var z : Double

	init(_ x : Double, _ y : Double, _ z : Double)
	{
		self.x = x
		self.y = y
		self.z = z
	}

	var description: String {return "Vector3: \(x), \(y), \(z)"}

	static func + (left: Vector3, right: Vector3) -> Vector3
	{
		return Vector3( left.x + right.x,
				left.y + right.y,
				left.z + right.z)
	}

	static func - (left: Vector3, right: Vector3) -> Vector3
	{
		return Vector3( left.x - right.x,
				left.y - right.y,
				left.z - right.z)
	}
    
    static func * (left: Vector3, right: Vector3) -> Vector3
    {
        return Vector3(left.x * right.x, left.y * right.y, left.z * right.z)
    }

	static func * (left: Double, right: Vector3) -> Vector3
	{
		return Vector3( left * right.x, left * right.y, left * right.z)
	} 
	
    static func * (left: Vector3, right: Double) -> Vector3
	{
		return Vector3( left.x * right, left.y * right, left.z * right)
	} 
}


