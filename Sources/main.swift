import Foundation
import Darwin

var resolution = 4
var scale = Vector3(1,1,1)
let path = CommandLine.arguments[CommandLine.arguments.count - 1]
var outputPath = path + ".obj"

//Process command line arguments
for i in 1 ..< CommandLine.arguments.count
{
    if CommandLine.arguments[i] == "-r" //Resolution
    {
        resolution = Int(CommandLine.arguments[i + 1])!
    }
    else if CommandLine.arguments[i] == "-s" //Scale
    {
        let sx = Double(CommandLine.arguments[i + 1])!
        let sy = Double(CommandLine.arguments[i + 2])!
        let sz = Double(CommandLine.arguments[i + 3])!
        
        scale = Vector3(sx, sy, sz)
    }
    else if CommandLine.arguments[i] == "-o" //Output File
    {
        outputPath = CommandLine.arguments[i + 1]
    }
    else if CommandLine.arguments[i] == "-help" //Help
    {
        print("Beyondagon v1.0.0")
        print("Usage: ./beyondagon [-r resolution] [-s scaleX scaleY scaleZ] [-o outputFile] <inputFile>")
        print("Defaults:               [r = 4]          [s = (1, 1, 1)]   [o = (inputFile).obj]")
        exit(0)
    }
}

let fileContents : String

do
{
    //Load the input file contents
    fileContents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
}
catch
{
    print("Error reading ")
    exit(0)
}

let lines = fileContents.components(separatedBy: "\n")

//Load the number of patches and vectors in the curve file
let numPatches = Int(lines[0])!
let numVectors = Int(lines[numPatches + 1])!
print("Loading curve file with \(numPatches) patches and \(numVectors) vectors")

var vectors = [Vector3]()

//Load all vectors from the curve file
for i in 0 ..< numVectors
{
    let curLine = lines[numPatches + 2 + i].components(separatedBy: ",")
    
    let x = Double(curLine[0])!
    let y = Double(curLine[1])!
    let z = Double(curLine[2])!
    
    let vec = Vector3(x, y, z) * scale
    vectors.append(vec)
}

var modelString = "vn 0 0 0\nvt 0 0\n"
var faceString = ""
var numFaces = 0
var numVerticies = 0

var lastPercent = 0.0;

//Loop through all patches computing poloygons for each
for i in 0 ..< numPatches
{
    //Print progress percent
    let percent = Double(i) / Double(numPatches) * 100
    if percent > lastPercent + 5
    {
        print(String(format: "%.2f%% done computing", percent))
        lastPercent = percent
    }
    
    //Load control points from curve file
    let controlPoints = lines[i + 1].components(separatedBy: ",").map{ vectors[Int($0)! - 1] }
    
    let modelStart = numVerticies
    
    //Compute verticies from the patch
    for u in 0 ... resolution
    {
        for v in 0 ... resolution
        {
            let curVec = pointOnPatch(controlPoints: controlPoints, at: Double(u) / Double(resolution), Double(v) / Double(resolution))
            
            modelString += "v \(curVec.x) \(curVec.y) \(curVec.z)\n"
            
            numVerticies += 1
        }
    }
    
    //Compute and write poloygons from computed verticies
    for u in 0 ..< resolution
    {
        for v in 0 ..< resolution
        {
            let f1 = v       * (resolution + 1) + u
            let f2 = v       * (resolution + 1) + u + 1
            let f3 = (v + 1) * (resolution + 1) + u + 1
            let f4 = (v + 1) * (resolution + 1) + u
            
            faceString += "f \(f1 + 1 + modelStart)/1/1 \(f3 + 1 + modelStart)/1/1 \(f2 + 1 + modelStart)/1/1\n"
            faceString += "f \(f1 + 1 + modelStart)/1/1 \(f4 + 1 + modelStart)/1/1 \(f3 + 1 + modelStart)/1/1\n"
            
            numFaces += 2
        }
    }
}

//Write finished model to disk
do
{
    try (modelString + faceString).write(toFile: outputPath, atomically: false, encoding: String.Encoding.utf8)
}
catch
{
    print("Error writing file to disk")
    exit(0)
}

print("Exported model with \(numFaces) faces and \(numVerticies) vertecies")
