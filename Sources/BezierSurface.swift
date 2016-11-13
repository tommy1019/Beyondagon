func pointOnPatch(controlPoints : [Vector3], at u : Double, _ v : Double) -> Vector3
{
    var res = [Vector3]()
    
    for i in 0 ..< 4
    {
        res.append(pointOnCurve(controlPoints[4 * i ..< 4 * (i + 1)], u))
    }
    
    return pointOnCurve(controlPoints: controlPoints, at: v)
}