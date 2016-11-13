func pointOnCurve(controlPoints : [Vector3] , at t : Double) -> Vector3
{
    let b0 = (1 - t) * (1 - t) * (1 - t)
    let b1 = 3 * t * (1 - t) * (1 - t)
    let b2 = 3 * t * t * (1 - t)
    let b3 = t * t * t;
    
    return controlPoints[0] * b0 + controlPoints[1] * b1 + controlPoints[2] * b2 + controlPoints[3] * b3;
}

func pointOnPatch(controlPoints : [Vector3], at u : Double, _ v : Double) -> Vector3
{
    var res = [Vector3]()
    
    for i in 0 ..< 4
    {
        res.append(pointOnCurve(controlPoints: Array(controlPoints[4 * i ..< 4 * (i + 1)]), at: u))
    }
        
    return pointOnCurve(controlPoints: res, at: v)
}