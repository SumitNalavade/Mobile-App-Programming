import { useState } from "react";
import { StyleSheet ,View, TextInput, TouchableOpacity, Text, Keyboard, TouchableWithoutFeedback } from "react-native";
import { Picker } from "@react-native-picker/picker";
import { mynancePurple } from "../../utils";

export default function AddTransactionForm({ addTransaction, setModalVisible }) {
    const [title, setTitle] = useState(null);
    const [amount, setAmount] = useState(null);
    const [category, setCategory] = useState('Unknown');
    const [type, setType] = useState('Unknown');
    
    const validateFields = () => {
        if(!title) {
            alert("Title is required");
            return false
        } else if (!amount) {
            alert("Amount is required");
            return false
        } else if(category === "Unknown") {
            alert("Select a category");
            return false
        } else if(type === "Unknown") {
            alert("Selet a type");
            return false
        }

        return true
    }

    return (
        <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
            <View style={styles.container}>
                    <View style={styles.innerContainer}>
                        <Text style={styles.headingLabel}>Title</Text>
                        <TextInput onChangeText={(evt) => setTitle(evt.trim())} style={[ styles.textInput]} />
                    </View>

                    <View style={styles.innerContainer}>
                        <Text style={styles.headingLabel}>Amount</Text>
                        <TextInput onChangeText={(evt) => setAmount(parseFloat(evt.trim()))} keyboardType="number-pad" returnKeyType="done"  placeholder="0.00" style={[ styles.textInput ]} />
                    </View>

                    <View style={styles.innerContainer}>
                        <Picker
                            selectedValue={category}
                            onValueChange={(value, index) => setCategory(value)}
                            mode="dropdown" // Android only
                            style={styles.picker} >
                            <Picker.Item label="Please select a category" value="Unknown" />
                            <Picker.Item label="Housing" value="Housing" />
                            <Picker.Item label="Transportation" value="Transportation" />
                            <Picker.Item label="Food" value="Food" />
                            <Picker.Item label="Utilities" value="Utilities" />
                            <Picker.Item label="Health" value="Health" />
                            <Picker.Item label="Savings" value="Savings" />
                            <Picker.Item label="Personal" value="Personal" />
                            <Picker.Item label="Entertainment" value="Entertainment" />
                            <Picker.Item label="Other" value="Other" />

                        </Picker>
                    </View>

                    
                    <View style={styles.innerContainer}>
                        <Picker
                            selectedValue={type}
                            onValueChange={(value, index) => setType(value)}
                            mode="dropdown" // Android only
                            style={styles.picker} >
                            <Picker.Item label="Please select a category" value="Unknown" />
                            <Picker.Item label="Expense" value="Expense" />
                            <Picker.Item label="Income" value="Income" />
                        </Picker>
                    </View>
                    
                    <TouchableOpacity onPress={() => {
                        if(validateFields()) {
                            addTransaction(title, amount, category, type);
                            return setModalVisible(false);
                        }

                        return
                    }} style={styles.submitButton}>
                        <Text style={styles.submitButtonText}>Add Transaction</Text>
                    </TouchableOpacity>
            </View>
        </TouchableWithoutFeedback>

    )
}

const styles = StyleSheet.create({
    textInput: {
        width: "90%",
        borderWidth: 1,
        borderColor: "lightgray",
        marginVertical: 10,
        height: 40,
        borderRadius: 10,
        textAlign: "center",
        fontSize: 30
    },

    headingLabel: {
        width: "100%",
        textAlign: "center",
        fontSize: 22,
        marginTop: 10,

        fontWeight: "bold",
        color: mynancePurple
    },

    submitButton: {
        width: "75%",
        marginHorizontal: "auto",
        paddingVertical: 15,
        paddingHorizontal: 10,
        borderRadius: 10,

        backgroundColor: mynancePurple,
        shadowColor: '#171717',
        shadowOffset: {width: -2, height: 4},
        shadowOpacity: 0.3,
        shadowRadius: 3,
    },

    submitButtonText: {
        color: "white",
        fontSize: 20,
        fontWeight: "bold",
        textAlign: "center"
    },  

    container: {
        flex: 1,
        width: "100%",
        margin: 20,
        justifyContent: "center",
        alignItems: "center"
    },

    innerContainer: {
        flexGrow: 1,
        width: "100%",
        alignItems: "center"
    },

    picker: {
        width: "100%",
    },
})