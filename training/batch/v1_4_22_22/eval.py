from happytransformer import HappyTextClassification, TCTrainArgs, TCEvalArgs
import pandas as pd
import pprint
import os, time



def evaluate(text):
	return HappyTextClassification.classify_text(text)

train_csv_str='./training_datasets/'
valid_csv_str='./validation_datasets/'
test_csv_str='./testing_datasets/'

weight_file = './output/preprocessed-data-1.json'

traing_csv_list=os.listdir(train_csv_str)
valid_csv_list=os.listdir(valid_csv_str)
test_csv_list=os.listdir(test_csv_str)


tdf=pd.read_csv(os.path.join(test_csv_str,test_csv_list[0]),delimiter=',')

happy_tc = HappyTextClassification(model_type="DISTILBERT",model_name="distilbert-base-uncased-finetuned-sst-2-english",num_labels=2)
tc_eval_args=TCEvalArgs(
	load_preprocessed_data=True,
	load_preprocessed_data_path='./output/preprocessed-data-1.json')
print(f'Eval on {weight_file}..')
#result = happy_tc.eval('./tc/tc_eval.csv', args=tc_eval_args)


# result = happy_tc.eval('./testing_datasets/crystal_non_testing_0422.csv', args=tc_eval_args)
# print(f'vars of result: {vars(result)}')



# with open(os.path.join(test_csv_str,os.listdir(test_csv_str)[0])) as f:
# 	x=f.readlines()
# 	print(x[1:2][:3])


guesses=[]
scores=[]
for i in range(len(tdf.text)):
	line=tdf.text[i]
	result = happy_tc.classify_text(line)
	label = happy_tc.classify_text(line).label
	#print(f'Network Guess {result.label} \n Network Score {result.score} \n Real Answer {"NEGATIVE" if tdf.label[i] is 0 else "POSITIVE"}')
	guesses.append(label)
	scores.append(result.score)
tdf['network_guess']=guesses
tdf['network_score']=scores

print(tdf)