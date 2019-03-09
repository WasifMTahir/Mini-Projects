//RollNo: 19100192

var fs = require('fs');
var path = require('path');

const readFile = file => new Promise((resolve, reject) =>
    fs.readFile(file, (err, data) => err ? reject(err) : resolve(data)))

var dictionary = [];
function readfiles (dir, prevFiles){
    var files = fs.readdir(dir);
    files.push(prevFiles);
    files.array.forEach(element => {
        var fileName = dir + '/' + element;
        if (fs.stat(fileName).isDirectory()){
            readfiles(fileName, files);
        }
        else{
            files.push(fileName);
            readFile(file).then(data => {
                var words = data.split("\n");
                for (var i in words){
                    var line = words[i].split(" ");
                    for (var j in line){
                        dictionary.push({
                            key: line(j),
                            value: fileName + ' on line number ' + i
                        })
                    }
                }
            })
        }
    });
    return files;
}