import { StyleSheet ,View, TextInput, TouchableOpacity, Text, KeyboardAvoidingView, Keyboard, TouchableWithoutFeedback } from "react-native";
import { mynancePurple } from "../../utils";

export default function AddTransactionForm() {
    return (
        <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
            <KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"} style={styles.container}>
                    <View style={styles.innerContainer}>
                        <Text style={styles.headingLabel}>Title</Text>
                        <TextInput style={[ styles.textInput, {height: 30 , borderRadius: 10, textAlign: "center", fontSize: 20}]} />
                    </View>

                    <View style={styles.innerContainer}>
                        <Text style={styles.headingLabel}>Amount</Text>
                        <TextInput keyboardType="number-pad" returnKeyType="done"  placeholder="0.00" style={[ styles.textInput ,{height: 60 , borderRadius: 15, textAlign: "center", fontSize: 35}]} />
                    </View>

                    <View style={styles.innerContainer}>
                        <Text style={styles.headingLabel} >Description</Text>
                        <TextInput returnKeyType="done" multiline={true} style={[ styles.textInput, {height: 150, borderRadius: 15, padding: 20, textAlign: "center"}]} />
                    </View>
                    
                    <TouchableOpacity style={styles.submitButton}>
                        <Text style={styles.submitButtonText}>Add Transaction</Text>
                    </TouchableOpacity>
            </KeyboardAvoidingView>
        </TouchableWithoutFeedback>

    )
}

const styles = StyleSheet.create({
    textInput: {
        width: "90%",
        borderWidth: 1,
        borderColor: "lightgray"
    },

    headingLabel: {
        width: "100%",
        textAlign: "center",
        fontSize: 22,
        marginVertical: 10,

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
        justifyContent: "space-evenly",
        alignItems: "center"
    },

    innerContainer: {
        flexGrow: 1,
        width: "100%",
        alignItems: "center"
    }
})