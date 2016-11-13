func pointOnCurve(controlPoints : [Vector3] , at t : Double) -> Vector3
{
	let b0 = (1 - t) * (1 - t) * (1 - t)
	let b1 = 3 * t * (1 - t) * (1 - t)
	let b2 = 3 * t * t * (1 - t)
	let b3 = t * t * t;
	return controlPoints[0] * b0 + controlPoints[1] * b1 + controlPoints[2] * b2 + controlPoints[3] * b3;
}
