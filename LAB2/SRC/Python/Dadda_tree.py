import math

nb = 32
radix = 4
first_level = int(nb/2+1)
levels = []
level_i = 2
num_levels = 0
shift = 0
partial_iter = 0
level_iter = 0
bit_cnt = 0
sum_i = 0
sum_i_1 = 0
HA_cnt = 0
FA_cnt = 0
row_cnt = 0

sum_pos = 0
carry_pos = 0

input_file = open('partial_product_0.txt', 'r')

levels.append(2)

partial_p =[]

#find the number of levels
while levels[num_levels] < first_level:
    level_i = int(level_i*3/2)
    levels.append(level_i)
    num_levels += 1

#initialize the partial product matrix    
for i in range (first_level):
    partial_p.append((2*nb+1)*'x ')
    partial_p[i] = partial_p[i].split()

levels[-1] = first_level

#read the input file in standard format
for line in input_file:
    for i in range (len(line.rstrip())):
        partial_p[partial_iter][i] = line[i]    
           
    if (partial_iter >= 1):
        partial_p[partial_iter][shift-1] = 'x'
        for j in range (shift-2):
            partial_p[partial_iter][j] = 'x'
            
    shift += int(math.log(radix,2))
    partial_iter += 1 
    
tmp_string = ''

#build the pyramid
for s in range (nb+4,2*nb):
    for r in range (first_level): 
        tmp_string += partial_p[r][s]
        
    tmp_string = tmp_string[::-1]
    
    for v in range (first_level): 
        partial_p[v][s] = tmp_string[v]    
    tmp_string = ''
        
input_file.close()  

output_file = open('DADDA_TREE.txt','w')    

while len(levels) > 1:

    result = []

    num_levels = len(levels)
    level_i = levels[num_levels-1]

    #initialize the results matrix   
    for k in range(levels[num_levels-2]):
        result.append((2*nb+1)*'x ')
        result[k] = result[k].split()
    
    output_file.write('\n--LEVEL %d\n\n' % (level_iter+1))

    #count the number of operand bits
    for col in range (2*nb):
        for row in range(level_i):
            if (partial_p[row][col] != 'x'):
                bit_cnt += 1
        
        while (bit_cnt+sum_i_1 > levels[num_levels-2]):
            
            #insert HA
            if (bit_cnt+sum_i_1-1 <= levels[num_levels-2]):
            
                result[sum_pos][col] = 'S'
                result[carry_pos][col+1] = 'C'
                output_file.write(('HA_%d : HA port map(A=>partial_p%d_%d(%d), B=>partial_p%d_%d(%d), S=>partial_p%d_%d(%d), C=>partial_p%d_%d(%d));\n' %(HA_cnt,levels[num_levels-1],row_cnt,col,levels[num_levels-1],row_cnt+1,col,levels[num_levels-2],sum_pos,col,levels[num_levels-2],carry_pos,col+1)))
                HA_cnt += 1
                bit_cnt -= 1
                sum_i += 1
                row_cnt += 2
                sum_pos += 1
                carry_pos += 1
            
            #insert FA    
            else:
                result[sum_pos][col] = 'S'
                result[carry_pos][col+1] = 'C'
                output_file.write(('FA_%d : FA port map(A=>partial_p%d_%d(%d), B=>partial_p%d_%d(%d), Cin => partial_p%d_%d(%d), S=>partial_p%d_%d(%d), Cout=>partial_p%d_%d(%d));\n' %(FA_cnt,levels[num_levels-1],row_cnt,col,levels[num_levels-1],row_cnt+1,col,levels[num_levels-1],row_cnt+2,col,levels[num_levels-2],sum_pos,col,levels[num_levels-2],carry_pos,col+1)))
                FA_cnt += 1
                bit_cnt -= 2
                sum_i += 1
                row_cnt += 3 
                sum_pos += 1
                carry_pos += 1     
        
        #copy the not added columns                       
        for r in range(sum_pos, levels[num_levels-2]):
            result[r][col] = partial_p[row_cnt][col]     
            output_file.write(('partial_p%d_%d(%d) <= partial_p%d_%d(%d);\n' % (levels[num_levels-2],r,col,levels[num_levels-1],row_cnt,col)))
            row_cnt += 1     
                
        sum_pos = carry_pos
        carry_pos = 0       
        sum_i_1 = sum_i
        sum_i = 0
        bit_cnt = 0
        row_cnt = 0   
    levels.pop(-1)
    partial_p = []
    partial_p = result
    level_iter += 1
    shift = 0
    partial_iter = 0
output_file.close()
