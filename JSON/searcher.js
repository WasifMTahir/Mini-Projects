//RollNo: 19100192

const args = process.argv;

if (args[2] == 'index'){
    readfiles(args[4]);
}
if (args[2] == 'search'){
    var toSearch = args[4];
    for (var i in toSearch){
        console.log(dictionary[toSearch[i]]);
    }
}