document.title = "Connect 4"
var a_canvas = document.createElement("canvas");
a_canvas.width = 350;
a_canvas.height = 350;
var mydiv = document.getElementById("root");
mydiv.appendChild(a_canvas);
var inst = document.createElement("br");
mydiv.appendChild(inst);
inst = document.createTextNode("Click on First Row to Play");
mydiv.appendChild(inst);
inst = document.createElement("br");
mydiv.appendChild(inst);

var context = a_canvas.getContext("2d");
var i, j;
for (i = 0; i<7; i++) {
    for (j=0; j<6; j++) {
        context.strokeRect(50*i, 50*j, 50, 50);
    }
}
var player = 1;
var boxes = new Array(42);
for (i = 0; i<42; i++) {
    boxes[i] = 'white';
}

function fillBox(event) {
    if (event.clientX<=350 && event.clientY<=50) {
        var posX = event.clientX - (event.clientX % 50);
        var posY = event.clientY - (event.clientY % 50);
        var index = (posX/50);
        for (i=0; i<6; i++)
        {
            if (i==5) {
                boxes[i*7 + index] = 'black';
                posX = 50*index;
                posY = 50*(i);
                if (player==1) {
                    context.fillRect(posX, posY, 50, 50);
                    player = 2;
                    inst = document.createTextNode("Player 2's Turn..");
                    mydiv.appendChild(inst);
                    inst = document.createElement("br");
                    mydiv.appendChild(inst);
                }
                else {
                    context.fillRect(posX+10, posY+10, 30, 30);
                    player = 1;
                    inst = document.createTextNode("Player 1's Turn..\n");
                    mydiv.appendChild(inst);
                    inst = document.createElement("br");
                    mydiv.appendChild(inst);
                }
            }
            else if (boxes[(i+1)*7 + index] == 'black'){
                boxes[i*7 + index] = 'black';
                posX = 50*index;
                posY = 50*(i);
                if (player==1) {
                    context.fillRect(posX, posY, 50, 50);
                    player = 2;
                    inst = document.createTextNode("Player 2's Turn..");
                    mydiv.appendChild(inst);
                    inst = document.createElement("br");
                    mydiv.appendChild(inst); }
                else {
                    context.fillRect(posX+10, posY+10, 30, 30);
                    player = 1;
                    inst = document.createTextNode("Player 1's Turn..");
                    mydiv.appendChild(inst);
                    inst = document.createElement("br");
                    mydiv.appendChild(inst); }
                    break;
            }
        }
    }
  }

document.addEventListener("click", fillBox);
/*
var Rectangle = React.createClass({
    render: function() {
        return this.transferPropsTo(
            <rect>{this.props.children}</rect>
        );
    }
});

React.renderComponent(
    <SVGComponent height="100" width="100">
        <Rectangle height="50" width="50" x="50" y="50" />
    </SVGComponent>,
    document.getElementById('svg_rectangle')
);*/

const readFile = f => new Promise((resolve, reject) =>
    fs.readFile(f, (e, d) => e?reject(e):resolve(d)))

const server = http.createServer(async (req, resp) =>
    resp.end(await readFile(req.url.substr(1))))

const io = socketio(server)
io.sockets.on('connection', socket => 
    socket.on(fillBox))