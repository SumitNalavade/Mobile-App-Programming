import 'react-native-gesture-handler';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';

import Profile from "./Components/Profile/Profile";
import Homescreen from './Components/Homescreen/Homescreen';
import AddTransaction from "./Components/AddTransaction/AddTransaction";

import { mynancePurple } from "./utils";

const Tab = createBottomTabNavigator();
export default function MyTabs() {

  return (
    <Tab.Navigator 
    screenOptions={({ route }) => ({
      tabBarIcon: ({ focused, color, size }) => {
        let iconName;
        focused == true ? color = mynancePurple : color = "gray"

        if (route.name === 'Home') {
          iconName = "ios-home"
        } else if (route.name === "Profile") {
          iconName = 'ios-person';
        }

        // You can return any component that you like here!
        return <Ionicons name={iconName} size={size} color={color} />;
      },

      presentation: "modal",

      tabBarActiveTintColor: 'purple',
      tabBarInactiveTintColor: 'gray',
      headerTitle: "Mynance",
      headerTintColor: "white",
      headerStyle: { backgroundColor: mynancePurple },
    })}
    >
      
      <Tab.Screen name="Home" component={Homescreen} />
      <Tab.Screen name="Profile" component={Profile} />
    </Tab.Navigator>
  );
}