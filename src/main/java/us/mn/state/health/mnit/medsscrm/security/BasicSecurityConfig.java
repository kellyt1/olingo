package us.mn.state.health.mnit.medsscrm.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import us.mn.state.health.mnit.medsscrm.data.ClientSecret;
import us.mn.state.health.mnit.medsscrm.utils.SecretsManager;

@Configuration
public class BasicSecurityConfig extends WebSecurityConfigurerAdapter{

    @Value("${secret.region}")
    private String secretRegion;

    @Value("${secret.name}")
    private String secretName;

    @Autowired
    private RestBasicAuthenticationEntryPoint authenticationEntryPoint;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
                .antMatchers("/odata/").permitAll()
                .and()
            .authorizeRequests()
                .antMatchers("/").permitAll()
                .anyRequest().authenticated()
                .and()
            .httpBasic()
            .authenticationEntryPoint(authenticationEntryPoint);
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth)
            throws Exception {
        ClientSecret secret = getKeyParams();
        String roles = "USER";
        auth.inMemoryAuthentication()
                .withUser(secret.getUsername())
                .password(passwordEncoder().encode(secret.getPassword()))
                .roles(roles);
    }

    private ClientSecret getKeyParams() {
        return SecretsManager.getClientSecret(this.secretRegion, this.secretName);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
