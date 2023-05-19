package com.example.another_back.config.auth;

/*
시큐리티가 /login주소 요청이 오면 낚아채서 로그인을 진행
로그인 진행이 완료되면 시큐리티 session만듬 (Security ContextHoler)
오브젝트 => Authentication 타입 객체
Authentication 안에 User정보가 있어야 됨.
User오브젝트타입 => UserDetails 타입 객체

//Security Session => Autemtication =>UserDetails 타입으로 각각 받을 수 있음
 */
import com.example.another_back.entity.User;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

@Data
public class PrincipalDetails implements UserDetails {

    private User user;

    public PrincipalDetails(User user){
        this.user = user;
    }

    //해당 User의 권한을 리턴하는 곳
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collect = new ArrayList<>();
//        user.getRoleList().forEach(r->{
//            collect.add(()->r);
//        });
        collect.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                return user.getRole().toString();
            }
        });
        return collect;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        //우리 사이트!! 1년동안 회원이 로그인을 안하면 !! 휴면 계정으로 하기로 함.
        // 현재 시간 -로그인 시간 => 1년초과하면 return false;
        //할 수 있는 메소드

        return true;
    }
}
