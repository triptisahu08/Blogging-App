class FieldValidator
{
  static String validateTitle(String value)
  {
    if(value.isEmpty)return 'Enter Title';
    if(value.length<5) {
      return 'Title must be more than 4 characters';
    }

      return null;
    }

  static String validateDescription(String value)
  {
    if(value.isEmpty)return 'Enter Description';
    if(value.length<20) {
      return 'Description must be more than 19 characters';
    }

    return null;

  }
}