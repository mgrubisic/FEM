function BernoulliBeam2D_Record
%  记录计算结果
global Node Element dU
    
fid=fopen('node_disp.txt','w');
[node_number,~] = size( Node ) ;
for i=1:node_number
%     微软自带txt文本打开器换行使用\r\n，一般使用\n
    fprintf(fid,'%i %f %f %f\r\n',i,dU((i-1)*3+1)+0,dU((i-1)*3+2)+0,dU((i-1)*3+1)+0); 
%     不加0会报错：错误使用 fprintf，没有为稀疏输入定义函数。
end
fclose(fid);

fid=fopen('element_node_force.txt','w');
[element_number, ~] = size( Element ) ;
for ie = 1:element_number
    enf = BernoulliBeam2D_ElementNodeForce( ie );
%     微软自带txt文本打开器换行使用\r\n，一般使用\n
    fprintf(fid,'%i %i %f %f %f\r\n',ie,Element(ie,1),enf(1),enf(2),enf(3)); 
    fprintf(fid,'%i %i %f %f %f\r\n',ie,Element(ie,2),enf(4),enf(5),enf(6));
%     分两行，第一行为单元的第一个节点处的轴力，剪力，弯矩
    
end
fclose(fid);

return