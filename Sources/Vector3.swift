struct Vector4 : Printable
{
	var x : Double
	var y : Double
	var z : Double

	init(x : Double, y : Double, z : Double)
	{
		self.x = x
		self.y = y
		self.z = z
	}

	override var description: String {return "Vector3: \(x), \(y), \(z)"}

	static func + (left: Vector3, right: Vector3) -> Vector3
	{
		return Vector3( x: left.x + right.x,
				y: left.y + right.y,
				z: left.z + right.z)
	}

	static func - (left: Vector3, right: Vector3) -> Vector3
	{
		return Vector3( x: left.x - right.x,
				y: left.y - right.y,
				z: left.z - right.z)
	}
}


