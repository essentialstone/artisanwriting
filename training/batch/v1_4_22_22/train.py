from happytransformer import HappyTextClassification, TCTrainArgs, TCEvalArgs
import pandas as pd
import pprint
import os, time
pd.option_context('display.max_rows', None, 'display.max_columns', None)
#decorate any function with this @timer and it will 
def timer(func):
	def wrapper():
		start_time=time.perf_counter()
		result=func()
		end_time=time.perf_counter()
		elapsed_time=end_time-start_time
		return  result, f'{func} took {elapsed_time}.'
	return wrapper[1]


train_csv_str='./training_datasets/'
valid_csv_str='./validation_datasets/'
test_csv_str='./testing_datasets/'

traing_csv_list=os.listdir(train_csv_str)
valid_csv_list=os.listdir(valid_csv_str)
test_csv_list=os.listdir(test_csv_str)

# tdf=pd.read_csv(os.path.join(train_csv_str,traing_csv_list[0]),delimiter='\t', names=['text','label'])

happy_tc = HappyTextClassification(model_type="DISTILBERT",model_name="distilbert-base-uncased-finetuned-sst-2-english",num_labels=2)
args= TCTrainArgs(
	learning_rate=5e-5,
	num_train_epochs=10,
	batch_size=1,
	weight_decay=0,
	adam_beta1=0.9,
	adam_beta2=0.999,
	adam_epsilon=1e-8,
	max_grad_norm=1.0,
	save_preprocessed_data=False, #this can be changed - need to look into it
	save_preprocessed_data_path='./output/preprocessed-data-1.json',
	load_preprocessed_data=True,
	load_preprocessed_data_path='./output/preprocessed-data-1.json',
	fp16=False)

training_file=os.path.join(train_csv_str,traing_csv_list[0])
validation_file=os.path.join(valid_csv_str,valid_csv_list[0])
test_file=os.path.join(test_csv_str,test_csv_list[0])


#print(f'Training on {training_file}..')
# happy_tc.train(input_filepath=	training_file, args=args)


tc_eval_args=TCEvalArgs(
	load_preprocessed_data=True,
	load_preprocessed_data_path='./output/preprocessed-data-1.json'	)
print(f'Eval on {training_file}..')
happy_tc.eval('./tc/tc_eval.csv', args=tc_eval_args)








# I need to randomize a set of test data for each run and have it compile and read in to the file that is passed to "test"






