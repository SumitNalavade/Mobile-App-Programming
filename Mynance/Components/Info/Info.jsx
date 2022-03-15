import { useEffect } from "react";
import { View, Text, StyleSheet, TextInput } from "react-native";
import { Picker } from "@react-native-picker/picker";

export default function Info({ route, navigation }) {
    const { transaction } = route.params
    const { title, amount } = transaction


    useEffect(() => {
        navigation.setOptions({title: title})
    }, [])

    return (
        <View style={{height: "100%", backgroundColor: "white", paddingVertical: 30}}>
            <View style={{flexDirection: "row", justifyContent: "center"}}>
                <TextInput keyboardType="number-pad" returnKeyType="done" placeholder={String(amount)} style={styles.textInput}/>
            </View>
        </View>
    )
}

const styles = StyleSheet.create({
    textInput: {
        width: "90%",
        borderWidth: 1,
        borderColor: "lightgray",
        marginVertical: 10,
        height: 60,
        borderRadius: 10,
        textAlign: "center",
        fontSize: 50,
    },

    picker: {
        width: "100%",
    }
})