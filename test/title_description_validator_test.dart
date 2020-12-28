import 'package:flutter_blog_app/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';
void main()
{
  test('Empty title test', ()
  {
    var result = FieldValidator.validateTitle('');
    expect(result, 'Enter Title');
  });
  test('Title length test', ()
  {
    var result = FieldValidator.validateTitle('code');
    expect(result, 'Title must be more than 4 characters');

  });

  test('Empty Description test', ()
  {
    var result = FieldValidator.validateDescription('');
    expect(result, 'Enter Description');
  });

  test('Description length test', ()
  {
    var result = FieldValidator.validateDescription('blog');
    expect(result,'Description must be more than 19 characters');
  });

  test('Description length test', ()
  {
    var result = FieldValidator.validateDescription('travel description');
    expect(result,'Description must be more than 19 characters');
  });


}