export const mynancePurple = "#673ab7";

export const saveItems = async() => {
    try {
      const transactionsString = JSON.stringify(transactions);
      await AsyncStorage.setItem('transactions', transactionsString);
    } catch (error) {
      // Error saving data
    }
  }


export const retrieveItems = async() => {
    try {
      const jsonValue = await AsyncStorage.getItem('transactions')
      return jsonValue != null ? JSON.parse(jsonValue) : null;
    } catch(e) {
      // error reading value
    }
  }