import 'react-native-gesture-handler';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { Ionicons } from '@expo/vector-icons';

import Profile from "./Components/Profile/Profile";
import Homescreen from './Components/Homescreen/Homescreen';
import Info from './Components/Info/Info';

import { mynancePurple } from "./utils";

const Tab = createBottomTabNavigator();
const HomeStack = createStackNavigator();

function HomeStackScreen() {
  return (
    <HomeStack.Navigator>
      <HomeStack.Screen name="Home" component={Homescreen} options={{headerShown: false}} />
      <HomeStack.Screen name="Info" component={Info} />
    </HomeStack.Navigator>
  );
}

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
      
      <Tab.Screen name="Home" component={HomeStackScreen} />
      <Tab.Screen name="Profile" component={Profile} />
    </Tab.Navigator>
  );
}