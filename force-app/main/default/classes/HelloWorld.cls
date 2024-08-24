public with sharing class HelloWorld {
    @AuraEnabled(cacheable=true)
    public static string sayHello(){
        return 'Hello world from controller';
    }
}