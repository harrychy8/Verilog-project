//these modules are for loading the memories

//front picture
module load_frontPic(clk,x,y,q);

input clk;
input[7:0] x;
input[6:0] y;
output [2:0] q;

frontM m0(
	.address(y*160 + x),
	.clock(clk),
	.q(q)
	);

endmodule


//start game picture
module load_startPic(clk,x,y,q);

input clk;
input[7:0] x;
input[6:0] y;
output [2:0] q;

startM m1(
	.address(y*160 + x),
	.clock(clk),
	.q(q)
	);

endmodule

//load win page
module load_winPic(clk,x,y,q);

input clk;
input[7:0] x;
input[6:0] y;
output [2:0] q;

winM m1(
	.address(y*160 + x),
	.clock(clk),
	.q(q)
	);

endmodule

//load lose page
module load_losePic(clk,x,y,q);

input clk;
input[7:0] x;
input[6:0] y;
output [2:0] q;

failedM m1(
	.address(y*160 + x),
	.clock(clk),
	.q(q)
	);

endmodule



//show score picture
module load_targetPic(clk,counter,q);

input clk;
input[5:0] counter;
output [2:0] q;

targetM m2(
	.address(counter),
	.clock(clk),
	.q(q)
	);

endmodule

