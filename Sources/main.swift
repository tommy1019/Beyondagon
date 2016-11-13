import Foundation

var resolution = 4

for i in 1 ..< CommandLine.arguments.count
{
    if CommandLine.arguments[i] == "-r"
    {
        resolution = Int(CommandLine.arguments[i + 1])!
    }
}

let path = CommandLine.arguments[CommandLine.arguments.count - 1]

let fileContents : String

do
{
    fileContents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
}
catch
{
    print("Error reading ")
    fileContents = ""
}

let lines = fileContents.components(separatedBy: "\n")

let numPatches = Int(lines[0])!
let numVectors = Int(lines[numPatches + 1])!
print("Loading curve file with \(numPatches) patches and \(numVectors) vectors")

var vectors = [Vector3]()

for i in 0 ..< numVectors
{
    let curLine = lines[numPatches + 2 + i].components(separatedBy: ",")
    
    let x = Double(curLine[0])!
    let y = Double(curLine[1])!
    let z = Double(curLine[2])!
    
    let vec = Vector3(x, y, z)
    vectors.append(vec)
}

var modelString = ""
var numFaces = 0
var numVerticies = 0

for i in 0 ..< numPatches
{
    let controlPoints = lines[i + 1].components(separatedBy: ",").map{ vectors[Int($0)! - 1] }
    
    var resVectors = [Vector3]()
    let modelStart = numVerticies
    
    for u in 0 ... resolution
    {
        for v in 0 ... resolution
        {
            let curVec = pointOnPatch(controlPoints: controlPoints, at: Double(u) / Double(resolution), Double(v) / Double(resolution))
            
            resVectors.append(curVec)
            modelString += "v \(curVec.x) \(curVec.y) \(curVec.z)\n"
            
            numVerticies += 1
        }
    }
    
    for u in 0 ..< resolution
    {
        for v in 0 ..< resolution
        {
            let f1 = v       * (resolution + 1) + u
            let f2 = v       * (resolution + 1) + u + 1
            let f3 = (v + 1) * (resolution + 1) + u + 1
            let f4 = (v + 1) * (resolution + 1) + u
            
            modelString += "f \(f1 + 1 + modelStart) \(f3 + 1 + modelStart) \(f2 + 1 + modelStart)\n"
            modelString += "f \(f1 + 1 + modelStart) \(f4 + 1 + modelStart) \(f3 + 1 + modelStart)\n"
            
            numFaces += 2
        }
    }
}

do
{
    try modelString.write(toFile: "\(path).obj", atomically: false, encoding: String.Encoding.utf8)
}
catch
{
    print("Error writing")
}

print("Exported model with \(numFaces) faces and \(numVerticies) vertecies")