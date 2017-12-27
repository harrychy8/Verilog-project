//the display for hex numbers
module seven_Segement_Decoder(out, in);

		input [3:0] in;
		output[6:0] out;
		
		//segement-0, number 1,4,B,D does not need it
		assign out[0] = //(~in[3]&~in[2]&~in[1]&~in[0])| // 0
							  (~in[3]&~in[2]&~in[1]& in[0])| // 1
						//	  (~in[3]&~in[2]& in[1]&~in[0])|	// 2
						//   (~in[3]&~in[2]& in[1]& in[0])| // 3
							  (~in[3]& in[2]&~in[1]&~in[0])| // 4
						//	  (~in[3]& in[2]&~in[1]& in[0])| // 5
						//	  (~in[3]& in[2]& in[1]&~in[0])| // 6
						//	  (~in[3]& in[2]& in[1]& in[0])| // 7
						//	  ( in[3]&~in[2]&~in[1]&~in[0])| // 8
						//	  ( in[3]&~in[2]&~in[1]& in[0])| // 9
						//	  ( in[3]&~in[2]& in[1]&~in[0])| // A
							  ( in[3]&~in[2]& in[1]& in[0])| // B
						//	  ( in[3]& in[2]&~in[1]&~in[0])| // C
							  ( in[3]& in[2]&~in[1]& in[0]); // D
						//	  ( in[3]& in[2]& in[1]&~in[0])| // E
						//	  ( in[3]& in[2]& in[1]& in[0])| // F
							  
		
		//segement-1, number 5,6,B,C,E,F does not need it
		assign out[1] = //(~in[3]&~in[2]&~in[1]&~in[0])| // 0
						//	  (~in[3]&~in[2]&~in[1]& in[0])| // 1
						//	  (~in[3]&~in[2]& in[1]&~in[0])|	// 2
						//   (~in[3]&~in[2]& in[1]& in[0])| // 3
						//	  (~in[3]& in[2]&~in[1]&~in[0])| // 4
							  (~in[3]& in[2]&~in[1]& in[0])| // 5
							  (~in[3]& in[2]& in[1]&~in[0])| // 6
						//	  (~in[3]& in[2]& in[1]& in[0])| // 7
						//	  ( in[3]&~in[2]&~in[1]&~in[0])| // 8
						//	  ( in[3]&~in[2]&~in[1]& in[0])| // 9
						//	  ( in[3]&~in[2]& in[1]&~in[0])| // A
							  ( in[3]&~in[2]& in[1]& in[0])| // B
							  ( in[3]& in[2]&~in[1]&~in[0])| // C
						//	  ( in[3]& in[2]&~in[1]& in[0])| // D
							  ( in[3]& in[2]& in[1]&~in[0])| // E
							  ( in[3]& in[2]& in[1]& in[0]); // F
							  
							  
		//segement-2, number 2,C,E,F does not need it
		assign out[2] = //(~in[3]&~in[2]&~in[1]&~in[0])| // 0
						//	  (~in[3]&~in[2]&~in[1]& in[0])| // 1
							  (~in[3]&~in[2]& in[1]&~in[0])|	// 2
						//   (~in[3]&~in[2]& in[1]& in[0])| // 3
						//	  (~in[3]& in[2]&~in[1]&~in[0])| // 4
						//	  (~in[3]& in[2]&~in[1]& in[0])| // 5
						//	  (~in[3]& in[2]& in[1]&~in[0])| // 6
						//	  (~in[3]& in[2]& in[1]& in[0])| // 7
						//	  ( in[3]&~in[2]&~in[1]&~in[0])| // 8
						//	  ( in[3]&~in[2]&~in[1]& in[0])| // 9
						//	  ( in[3]&~in[2]& in[1]&~in[0])| // A
						//	  ( in[3]&~in[2]& in[1]& in[0])| // B
							  ( in[3]& in[2]&~in[1]&~in[0])| // C
						//	  ( in[3]& in[2]&~in[1]& in[0])| // D
							  ( in[3]& in[2]& in[1]&~in[0])| // E
							  ( in[3]& in[2]& in[1]& in[0]); // F
							  
							  
							  
		//segement-3, number 1,4,7,A,F does not need it
		assign out[3] = //(~in[3]&~in[2]&~in[1]&~in[0])| // 0
							  (~in[3]&~in[2]&~in[1]& in[0])| // 1
						//	  (~in[3]&~in[2]& in[1]&~in[0])|	// 2
						//   (~in[3]&~in[2]& in[1]& in[0])| // 3
							  (~in[3]& in[2]&~in[1]&~in[0])| // 4
						//	  (~in[3]& in[2]&~in[1]& in[0])| // 5
						//	  (~in[3]& in[2]& in[1]&~in[0])| // 6
							  (~in[3]& in[2]& in[1]& in[0])| // 7
						//	  ( in[3]&~in[2]&~in[1]&~in[0])| // 8
						//	  ( in[3]&~in[2]&~in[1]& in[0])| // 9
							  ( in[3]&~in[2]& in[1]&~in[0])| // A
						//	  ( in[3]&~in[2]& in[1]& in[0])| // B
						//	  ( in[3]& in[2]&~in[1]&~in[0])| // C
						//	  ( in[3]& in[2]&~in[1]& in[0])| // D
						//	  ( in[3]& in[2]& in[1]&~in[0])| // E
							  ( in[3]& in[2]& in[1]& in[0]); // F
							  
							  
							  
		//segement-4, number 1,3,4,5,7,9 does not need it
		assign out[4] = //(~in[3]&~in[2]&~in[1]&~in[0])| // 0
							  (~in[3]&~in[2]&~in[1]& in[0])| // 1
						//	  (~in[3]&~in[2]& in[1]&~in[0])|	// 2
						     (~in[3]&~in[2]& in[1]& in[0])| // 3
							  (~in[3]& in[2]&~in[1]&~in[0])| // 4
							  (~in[3]& in[2]&~in[1]& in[0])| // 5
						//	  (~in[3]& in[2]& in[1]&~in[0])| // 6
							  (~in[3]& in[2]& in[1]& in[0])| // 7
						//	  ( in[3]&~in[2]&~in[1]&~in[0])| // 8
							  ( in[3]&~in[2]&~in[1]& in[0]); // 9
						//	  ( in[3]&~in[2]& in[1]&~in[0])| // A
						//   ( in[3]&~in[2]& in[1]& in[0])| // B
						//   ( in[3]& in[2]&~in[1]&~in[0])| // C
						//	  ( in[3]& in[2]&~in[1]& in[0])| // D
						//	  ( in[3]& in[2]& in[1]&~in[0])| // E
						//	  ( in[3]& in[2]& in[1]& in[0])| // F
							  
							  
							  
		//segement-5, number 1,2,3,7,D does not need it
		assign out[5] = //(~in[3]&~in[2]&~in[1]&~in[0])| // 0
							  (~in[3]&~in[2]&~in[1]& in[0])| // 1
							  (~in[3]&~in[2]& in[1]&~in[0])|	// 2
						     (~in[3]&~in[2]& in[1]& in[0])| // 3
						//	  (~in[3]& in[2]&~in[1]&~in[0])| // 4
						//	  (~in[3]& in[2]&~in[1]& in[0])| // 5
						//	  (~in[3]& in[2]& in[1]&~in[0])| // 6
							  (~in[3]& in[2]& in[1]& in[0])| // 7
						//	  ( in[3]&~in[2]&~in[1]&~in[0])| // 8
						//	  ( in[3]&~in[2]&~in[1]& in[0])| // 9
						//	  ( in[3]&~in[2]& in[1]&~in[0])| // A
						//	  ( in[3]&~in[2]& in[1]& in[0])| // B
						//	  ( in[3]& in[2]&~in[1]&~in[0])| // C
							  ( in[3]& in[2]&~in[1]& in[0]); // D
						//	  ( in[3]& in[2]& in[1]&~in[0])| // E
						//	  ( in[3]& in[2]& in[1]& in[0])| // F
							  
							  
							  
							  
		//segement-6, number 0,1,7,C does not need it
		assign out[6] = (~in[3]&~in[2]&~in[1]&~in[0])| // 0
							  (~in[3]&~in[2]&~in[1]& in[0])| // 1
						//	  (~in[3]&~in[2]& in[1]&~in[0])|	// 2
						//   (~in[3]&~in[2]& in[1]& in[0])| // 3
						//	  (~in[3]& in[2]&~in[1]&~in[0])| // 4
						//	  (~in[3]& in[2]&~in[1]& in[0])| // 5
						//	  (~in[3]& in[2]& in[1]&~in[0])| // 6
							  (~in[3]& in[2]& in[1]& in[0])| // 7
						//	  ( in[3]&~in[2]&~in[1]&~in[0])| // 8
						//	  ( in[3]&~in[2]&~in[1]& in[0])| // 9
						//	  ( in[3]&~in[2]& in[1]&~in[0])| // A
						//	  ( in[3]&~in[2]& in[1]& in[0])| // B
							  ( in[3]& in[2]&~in[1]&~in[0]); // C
						//	  ( in[3]& in[2]&~in[1]& in[0])| // D
						//	  ( in[3]& in[2]& in[1]&~in[0])| // E
						//	  ( in[3]& in[2]& in[1]& in[0])| // F
							
endmodule 